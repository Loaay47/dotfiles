#!/bin/bash

doas rm -f config.h
printf "removing config.h\n"
doas make install clean
printf "dwm has been compiled successfully\n"
