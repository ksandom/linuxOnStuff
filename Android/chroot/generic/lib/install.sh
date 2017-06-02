# Stuff to get it installed.

function sanityChecks
{
  echo "Performing sanity checks."
  
  # Sanity checks.
  if mkdir -p "$configDir"; then
    # Everything is ok.
    return 0
  else
    echo "Could not create \"$configDir\". Please check permissions." >&2
    exit 1
  fi
}

function doInstall
{
  # Prepare.
  mkdir -vp $configDir/{bin,config,config.d,lib,mnt,state,supplimentary}

  # Copy stuff.
  for dirName in bin config config.d lib supplimentary; do
    cp -v $dirName/* "$configDir/$dirName"
  done

  # Permissions.
  chmod 755 "$configDir/bin"/*

  # Build bin.
  if [ "$configDir" != "/sdcard/.cr" ]; then
    cd "$configDir/bin"
    for filename in *;do
      echo "Adapting $filename for install location of \"$configDir\""
      sed -i "s#/sdcard/.cr#$configDir#g" $filename
    done
    cd ~-
  fi

  # Place executable.
  cd "$configDir"
  cp bin/cr.android ../cr
}