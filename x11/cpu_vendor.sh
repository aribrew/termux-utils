#!/bin/bash

cat /proc/cpuinfo | grep -m 1  vendor_id | xargs | cut -d ':' -f 2 | xargs

