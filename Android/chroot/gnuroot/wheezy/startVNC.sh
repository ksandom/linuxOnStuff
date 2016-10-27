#!/bin/bash
# Start the VNC server.

export DISPLAY=:10
export USER=me

vncserver -geometry 3200x1800 -depth 24 :10

