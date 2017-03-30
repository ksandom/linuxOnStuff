# Library for NF.

function prepNF
{
  # Make sure our temp directory exists.
  mkdir -p "$tempDirectory"
}

function getInitialState
{
  # Get initial state.
  cd "$directoryToMonitor"
  ls -1 | sort -u > "$tempDirectory/$$-before"
}

function watchDirectory
{
  # Compare state every 1 second.
  while sleep 1;do
    clear
    date
    ls -1 | sort -u > "$tempDirectory/$$-during"
    
    diff "$tempDirectory/$$-before" "$tempDirectory/$$-during"
  done
}

function doNF
{
  prepNF
  getInitialState
  watchDirectory
}
