# Stuff for managing the mounting and umounting of stuff.

#
# Stuff for settup up the chroot.
#
function isMounted
{
  dst="$1"  
  isThereStuff=$(ls $dst | wc -l 2>/dev/null)
  
  if [ "$isThereStuff" -gt 0 ]; then
    return 0
  else
    return 1
  fi
}

function isMounted2
{
  dst="`echo $1 | cut -d/ -f 3-`" 
  isThereStuff=$(mount | grep "$dst ")
  
  if [ "$isThereStuff" == "" ]; then
    return 1
  else
    return 0
  fi
}


function essentials
{
  echo -n "$crHome  "
  if ! isMounted "$crHome";  then
    mkdir -p "$crHome"
    if [ "$rootPartition" != "" ]; then
      echo "mount - partition. ($rootPartition)"
      mount "$rootPartition" "$crHome"
    elif [ "$rootImage" != "" ]; then
      echo "mount - image. ($rootImage)"
      mount -o loop "$rootImage" "$crHome"
    else
      echo "No root image or partition configured?"
      return 0
    fi
  else
    echo "skipped."
  fi
}

function unessentials
{
  echo -n "$crHome  "
  if isMounted "$crhome";  then
    echo "unmount."
    umount $crHome 
  else
    echo "skipped."
  fi
}



function tryMount
{
  bindThing="$1"
  dst="$crHome/$bindThing"
  echo -n "  /$bindThing => $dst"
    
  if isMounted $dst; then
    echo " - skipping"
  else
    echo " - binding"
    mount -o bind /$bindThing $dst
  fi
}

function tryUnmount
{
  bindThing="$1"
  dst="$crHome/$bindThing"
  echo -n "  $dst"
    
  if isMounted $dst; then
    echo " - unbinding"
    umount "$dst"
  else
    echo " - skipping"
  fi
}


function mountExtras
{
  for fs in $extraMounts; do
    tryMount "$fs"
  done
}

function unmountExtras
{
  for fs in $extraUnmounts; do
    tryUnmount "$fs"
  done
}

function mountAll
{
  essentials
  mountExtras
}


function unmountAll
{
  unmountExtras
  unessentials
}

function mountStatus
{
  echo -n "$crHome  "
  if isMounted2 "$crHome "; then
    echo "mounted"
  else
    echo "not mounted"
  fi
  
  for fs in $extraMounts; do
    echo -n " $fs  "
    if isMounted2 "$crHome/$fs"; then
      echo "mounted"
    else
      echo "not mounted"
    fi
  done
}

