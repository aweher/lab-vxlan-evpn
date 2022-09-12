#!/usr/bin/env python
# Created by Ariel S. Weher <ariel[at]weher[dot]net>

from menu import LabMenu
import signal

def never_gonna_let_you_out(sig, frame):
    print("\nhttps://www.youtube.com/watch?v=dQw4w9WgXcQ\n")

signal.signal(signal.SIGINT, never_gonna_let_you_out)
menu = LabMenu()

while True:
    menu.show()