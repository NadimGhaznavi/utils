#!/usr/bin/python3

import urwid
from urwid import LineBox, Text, Pile, Columns, CheckBox, Button, AttrMap

# Catchall function to handle user input
def parse_input(key: str) -> None:

  if key in ['q', 'Q']:
    # If user enters a "Q" exit the main loop
    raise urwid.ExitMainLoop()
  
# Define a palette where 
#  - The first element of the tuple is a lable for the entry
#  - The second element is the foreground
#  - The third element is the background
palette = [
  ('header', 'light green', 'black'),
  ('default', 'light green', 'black'),
]

# Title text
title_widget = LineBox(Text(' PATCH NODES '))
title_map = AttrMap(title_widget, 'header')

# Selection help text
select_help_widget = Text('Select which hosts you want to patch:\n')
select_help_map = AttrMap(select_help_widget, 'default')

# Host selection
sally_widget = CheckBox("sally.osoyalce.com")
sally_map = AttrMap(sally_widget, 'default')
kermit_widget = CheckBox("kermit.osoyalce.com")
kermit_map = AttrMap(kermit_widget, 'default')
phoebe_widget = CheckBox("phoebe.osoyalce.com")
phoebe_map = AttrMap(phoebe_widget, 'default')
maia_widget = CheckBox("maia.osoyalce.com")
maia_map = AttrMap(maia_widget, 'default')
brat_widget = CheckBox("brat.osoyalce.com")
brat_map = AttrMap(brat_widget, 'default')

host_map_list = [
  select_help_map,
  sally_map,
  kermit_map,
  phoebe_map,
  maia_map,
  brat_map
]

hosts_map = AttrMap(LineBox(Pile(host_map_list)), 'default')

# Okay and cancel buttons
okay_widget = Button("OK")
okay_map = AttrMap(okay_widget, 'header')
cancel_widget = Button("Cancel")
cancel_map = AttrMap(cancel_widget, 'header')
buttons_list = Columns([(6, okay_map), (10, cancel_map)], dividechars = 2)
buttons_map = AttrMap(LineBox(AttrMap(buttons_list, 'header')), 'header')

widget_list = [
  title_map,
  hosts_map,
  buttons_map
]

# Assemble the widgets
screen = Pile(widget_list)

# Fill the screen
#  - Align the widget at the top of the screen
fill = urwid.Filler(screen, 'top')

# Setup the loop
loop = urwid.MainLoop(fill, palette, unhandled_input=parse_input)

# Run the loop
loop.run()

