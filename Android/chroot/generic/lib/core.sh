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
  grep "^  *\".*#" $1 | sed 's/") #/:/g;s/^ *"//g' | column -t -s:
}


function chooseOption
{
  case "$1" in
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
      showHelp "$crManagerHome/lib/core.sh"
    ;;
  esac
}

function chooseImage
{
  case "$1" in
    "list")
      listConfigsWithDescriptions
    ;;
    "")
      listConfigsWithDescriptions
    ;;
    "help")
      # TODO this needs to be better thought out.
      showHelp "$crManagerHome/lib/core.sh"
    ;;
    *)
      setConfigContext "$1" "$2" "$3"
    ;;
  esac
}