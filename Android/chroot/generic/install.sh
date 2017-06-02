#!/bin/bash
# CR - The chroot manager.
# This script installs CR. View the readme.md for more information.
#
# Syntax
#   ./install.sh [locationToInstall]
#
#   locationToInstall defaults to /sdcard, but if you enter something
#     it will install to the specified location instead.
# Eg
#   ./install.sh /sdcard/stuff
#
#   Would install stuff like this:
#     /sdcard/
#       stuff/
#         cr          - The thing to run outside the chroot environments.
#         .cr/
#           bin       - More useful stuff to run.
#           config.d  - Where you configure your chroots.
#           lib       - Code that makes thing go.
#           mnt       - Where the images get mounted.
#           state     - For internally tracking the state of each chroot.


# Figure out how stuff needs to be installed.
installLocation=${1:-/sdcard}
configDir="$installLocation/.cr"
binPath="$installLocation/cr"

# Get the library to do the grunt work.
. lib/install.sh

sanityChecks && doInstall
