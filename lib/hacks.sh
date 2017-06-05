# Hacks to make stuff work.

function hack
{
  echo "Applying hack: $1"
}

function hackFD
{
  if [ ! -e /dev/fd ]; then
    hack "/dev/fd"
    cd /dev
    ln -s /proc/self/fd .
    cd ~-
  fi
}

function applyAllHacks
{
  hackFD
}
