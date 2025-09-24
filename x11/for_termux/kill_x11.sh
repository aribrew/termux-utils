#!/bin/bash

echo "Stopping running X11 server ..."

kill -9 $(pgrep -f "termux-x11") 2> /dev/null

