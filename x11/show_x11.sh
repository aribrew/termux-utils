#!/bin/bash

echo "Trying to start Termux:X11."
echo "If the app does not open, open it manually."
echo ""

am start -S -n com.termux.x11/.MainActivity
