# Core functionality for getting everything going.


function startCR
{
  export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
  hostname `cat $crHome/etc/hostname`
  chroot "$crHome" bash -
}


function status
{
  mountStatus
  showVNCStatus
}


function showHelp {
  grep "^  *\".*#" $1 | sed 's/") #/  /g;s/^ *"//g'
}



case $1 in
  "start") # Start chroot and all necessary dependancies.
    mountAll
    startCR
  ;;
  "stop") # Stop chroot and all necessary dependencies.
    unmountAll
  ;;
  "startVNC") # Start VNC and all necessary dependancies.
    mountAll
    VNCStart
  ;;
  "stopVNC") # Stop VNC.
    VNCStop
  ;;
  "status") # Show the status of everything we know about.
    status
  ;;
  *)
    showHelp "$0"
  ;;
esac
