# Core functionality for getting everything going.


function startCR
{
  export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
  setHostname
  chroot "$crHome" bash -
}

function runInCR
{
  command="$1"
  export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
  setHostname
  chroot "$crHome" /bin/bash -c "$command"
}

function runInCRAsUser
{
  export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
  setHostname
  echo "runInCRAsUser"
  chroot "$crHome" su - "$nonRootUser" -c "$@"
}

function startCRAsUser
{
  export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
  setHostname
  echo "startCRAsUser"
  chroot "$crHome" su - "$nonRootUser"
}


function setHostname
{
  hostnamePath="$crHome/etc/hostname"
  echo "$configName" > "$hostnamePath"
  hostname `cat $hostnamePath`
}

function status
{
  mountStatus
  showVNCStatus
}


function showHelp {
  grep "^  *\".*#" $1 | sed 's/") #/:/g;s/^ *"//g' | formatOutput
}


function chooseOption
{
  case "$1" in
    "setup") # Setup a chroot for day-to-day usage.
      setupChroot
    ;;
    "start") # Start chroot and all necessary dependancies.
      mountAll
      installConvenience
      startCRAsUser
    ;;
    "startRoot") # Start chroot as root and all necessary dependancies.
      mountAll
      installConvenience
      startCR
    ;;
    "stop") # Stop chroot and all necessary dependencies.
      unmountAll
    ;;
    "startVNC") # Start VNC and all necessary dependancies.
      mountAll
      installConvenience
      VNCStartAsUser
    ;;
    "startVNCRoot") # DEPRECATED Start VNC as root and all necessary dependancies.
      mountAll
      installConvenience
      VNCStart
    ;;
    "stopVNC") # Stop VNC.
      uninstallConvenience
      VNCStopAsUser
    ;;
    "stopVNCRoot") # DEPRECATED Stop Root VNC.
      uninstallConvenience
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