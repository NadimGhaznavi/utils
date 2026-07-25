#!/usr/bin/env bash

# Deliberately do not use "set -e":
# smartctl uses non-zero exit statuses to report disk conditions.
set -u
set -o pipefail

PATH=/usr/sbin:/usr/bin:/sbin:/bin

MAIL_TO="nghaznavi@gmail.com"
MAIL_FROM="nghaznavi@gmail.com"
MSMTP_CONFIG="/root/.msmtprc"

# Use stable identifiers rather than /dev/sda and /dev/sdb.
DISKS=(
    "/dev/disk/by-id/ata-ST8000DM004-2U9188_ZR161KM0"
    "/dev/disk/by-id/ata-ST8000DM004-2U9188_ZR161M2Z"
)

hostname="$(hostname -f 2>/dev/null || hostname)"
report=""
overall_failed=0

append_report()
{
    report+="$1"$'\n'
}

for disk in "${DISKS[@]}"; do
    append_report "============================================================"
    append_report "Disk: $disk"

    if [[ ! -b "$disk" ]]; then
        append_report "FAIL: Device is missing or is not a block device."
        overall_failed=1
        continue
    fi

    smart_output="$(smartctl -H -A "$disk" 2>&1)"
    smart_status=$?

    disk_failed=0

    # Bits 0-5 cover:
    #   command errors
    #   device-access errors
    #   SMART command errors
    #   failed overall health
    #   currently failed attributes
    #   attributes that failed previously
    if (( smart_status & 0x3f )); then
        append_report "FAIL: smartctl exit status: $smart_status"
        disk_failed=1
    fi

    # Important ATA attributes that can indicate degradation before
    # the drive's overall SMART health changes to FAILED.
    #
    #   5   Reallocated sectors
    #   187 Reported uncorrectable errors
    #   196 Reallocation events
    #   197 Pending sectors
    #   198 Offline uncorrectable sectors
    for attribute_id in 5 187 196 197 198; do
        attribute="$(
            awk -v id="$attribute_id" \
                '$1 == id { print $2, $10; exit }' \
                <<< "$smart_output"
        )"

        # Some drives do not implement every attribute.
        [[ -z "$attribute" ]] && continue

        attribute_name="${attribute% *}"
        raw_value="${attribute##* }"

        if [[ "$raw_value" =~ ^[0-9]+$ ]] && (( raw_value > 0 )); then
            append_report "FAIL: $attribute_name = $raw_value"
            disk_failed=1
        fi
    done

    if (( disk_failed )); then
        overall_failed=1
        append_report ""
        append_report "$smart_output"
    else
        append_report "PASS"
    fi
done

append_report "============================================================"

if (( overall_failed )); then
    append_report "Overall result: FAIL"

    # Also print the report for cron/syslog capture.
    printf '%s\n' "$report"

    {
        printf 'To: %s\n' "$MAIL_TO"
        printf 'From: %s\n' "$MAIL_FROM"
        printf 'Subject: SMART disk alert on %s\n' "$hostname"
        printf 'Date: %s\n' "$(date -R)"
        printf 'Content-Type: text/plain; charset=UTF-8\n'
        printf '\n'
        printf '%s\n' "$report"
    } | msmtp --file="$MSMTP_CONFIG" --account=default -t

    exit 1
fi

append_report "Overall result: PASS"
printf '%s\n' "$report"
exit 0

