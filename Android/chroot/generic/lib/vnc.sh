# Stuff for managing VNC.

#
# Stuff for managing VNC.
#
function getVNCLockFile
{
  echo $crHome/tmp/.X$vncNumber-lock
}

function getVNCPidFile
{
  echo $crHome/.vnc/localhost:$vncNumber.pid
}

function getVNCPid
{
  vncLockFile=`getVNCLockFile`
  if [ -e `getVNCLockFile` ];then
    sed 's/ *//g' "$vncLockFile"
  fi
}


function VNCLockExists
{
  [ -e `getVNCLockFile` ] || [ -e `getVNCPidFile`  ]
  return $?
}

function VNCProcessExists
{
  pid=`getVNCPid`
  
  kill -0 $pid 2>/dev/null
  return $?
}

function isVNCRunning
{
  if VNCLockExists; then
    if VNCProcessExists; then
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
}

function VNCStart
{
  echo -n "VNC start  "
  if VNCProcessExists; then
    echo "skipped."
  else
    if VNCLockExists; then
      echo "... lock still exists. Removing."
      VNCStop
    fi
    
    echo "VNC start  starting."
    export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH   
    hostname `cat $crHome/etc/hostname`
    
    extraOptions=""
    if [ "$vncDPI" != "" ]; then
      extraOptions="$extraOptions -dpi $vncDPI"
    fi
    
    if [ "$vncNumber" != "" ]; then
      extraOptions="$extraOptions :$vncNumber"
    fi
    
    chroot "$crHome" vncserver -geometry "$vncResolution" $extraOptions
  fi
}

function VNCRemoveLock
{
  rm -Rf $crHome/tmp/.X$vncNumber-lock $crHome/tmp/.X11-unix/X$vncNumber $crHome/.vnc/localhost:$vncNumber.pid
}

function VNCStop
{
  echo -n "VNC stop  "
  if VNCLockExists; then
    echo "stopping."
    export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH    
    export HOME=/
    chroot "$crHome" vncserver -kill :1
    
    if VNCProcessExists; then
      echo "Whoops, VNC wasn't able to stop. A little self control may be required ;-)"
    else
      if VNCLockExists; then
  echo "The lock still exists, but the process doesn't. Removing."
        VNCRemoveLock
      fi
    fi
  else
    echo "skipped."
  fi
}


function showVNCStatus
{
  echo "VNC/desktop"
  vncLockFile=`getVNCLockFile`
  
  echo -n " VNC lock on :$vncNumber ($vncLockFile)  "
  if VNCLockExists; then
    echo "Yes."
    echo -n " Running  "
    if VNCProcessExists; then
      pid=$(getVNCPid)
      echo "Yes ($pid)."
    else
      echo "No."
    fi
  else
    echo "No."
  fi
}



