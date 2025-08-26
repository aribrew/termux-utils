#!/bin/bash

echo "Stopping running Pulseaudio server ..."
kill -9 $(pgrep -f "pulseaudio") 2> /dev/null

