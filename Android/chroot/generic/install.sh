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
testBinPath="$installLocation/cr.test" # TODO remove this.

# Sanity checks.
if mkdir -p "$configDir"; then
  # Everything is ok.
  true
else
  echo "Could not create \"$configDir\". Please check permissions." >&2
  exit 1
fi

# Prepare.
mkdir -vp $configDir/{bin,config,config.d,lib,mnt,state}

# Copy stuff.
for dirName in bin config config.d lib; do
  cp -v $dirName/* "$configDir/$dirName"
done

# Permissions.
chmod 755 "$configDir/bin"/*

# Build bin.
# TODO Do this.
