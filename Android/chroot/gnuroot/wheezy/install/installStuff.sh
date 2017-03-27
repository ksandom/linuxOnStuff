#!/bin/bash
# Installs everything needed for a development desktop.

packages="vim git nmon php5 curl screen iceweasel kate konsole rekonq icewm vnc-server"

apt-get update
apt-get install $packages
