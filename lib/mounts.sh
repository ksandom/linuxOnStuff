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
      mountViaLoop "$rootImage" "$crHome"
    else
      echo "No root image or partition configured?"
      return 0
    fi
  else
    echo "skipped."
  fi
}

function mountViaLoop
{
  mountImage="$1"
  mountLocation="$2"
  
  # Method to use to mount the initial image. Currently can be
  # * oLoop           Normal mount with -o loop.
  # * loSetup         Use losetup to set up a loopback device first. 
  #                     Makes implementation assumptions. Is unlikely to work for your
  #                     use case.
  # * busyboxOLoop    Use the busybox mount with -o loop.
  # * busyboxLoSetup  Use the busybox version of losetup.
  #                     Makes implementation assumptions. Is unlikely to work for your
  #                     use case.
  
  case $loopMountMethod in
    'oLoop')
      echo "  -o loop"
      mount -o loop "$mountImage" "$mountLocation"
    ;;
    'loSetup')
      echo "  losetup"
      deviceName=`losetup -f `
      mount "$deviceName" "$mountLocation"
    ;;
    'busyboxOLoop')
      echo "  busybox based mount -o loop"
      busybox mount -o loop "$mountImage" "$mountLocation"
    ;;
    'busyboxLoSetup')
      echo "  busybox based losetup"
      deviceName=`busybox losetup -f `
      mount "$deviceName" "$mountLocation"
    ;;
  esac
}

function unmountLoop
{
  mountLocation="$1"
  
  # Method to use to mount the initial image. Currently can be
  # * oLoop           Normal mount with -o loop.
  # * loSetup         Use losetup to set up a loopback device first. 
  #                     Makes implementation assumptions. Is unlikely to work for your
  #                     use case.
  # * busyboxOLoop    Use the busybox mount with -o loop.
  # * busyboxLoSetup  Use the busybox version of losetup.
  #                     Makes implementation assumptions. Is unlikely to work for your
  #                     use case.
  
  case $loopMountMethod in
    'oLoop')
      umount "$mountLocation"
    ;;
    'loSetup')
      # deviceName=`losetup -f `
      # TODO Find the deviceName. This can proabbly be done by grepping mount.
      umount "$mountLocation"
    ;;
    'busyboxOLoop')
      busybox umount "$mountLocation"
    ;;
    'busyboxLoSetup')
      # TODO Find the deviceName. This can proabbly be done by grepping mount.
      # deviceName=`busybox losetup -f `
      umount "$mountLocation"
    ;;
  esac
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

