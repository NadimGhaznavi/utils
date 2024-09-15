#!/usr/bin/python3

import urwid

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
  ('header', 'yellow', 'dark blue'),
  ('default', 'light green', 'black'),
]
# Header text widget
#  - Apply the 'header' palette text attributes
#  - Center the text horizontally
header_widget = urwid.Text(('header', '\nPATCH NODES\n'), align='center')
# Define the foreground and background for the rest of the widget's space
header_map = urwid.AttrMap(header_widget, 'header')

# Fill the screen
#  - Align the widget at the top of the screen
fill = urwid.Filler(header_map, 'top')

# Setup the loop
loop = urwid.MainLoop(fill, palette, unhandled_input=parse_input)

# Run the loop
loop.run()

