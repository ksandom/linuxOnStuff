# Stuff for making the output to the user pretty.

function getFormatter
{
  if which column > /dev/null; then
    echo "column"
  elif which sed > /dev/null; then
    echo "sed"
  else
    echo "noFormatter"
  fi
}

function noFormatter
{
  while read in; do
    echo "$in"
  done
}

function formatOutput
{
  case "$formatter" in
    "column")
      column -t -s:
    ;;
    "sed")
      sed 's/:/       /g'
    ;;
    *)
      echo "Fell back to noFormatter. The chosen formatter was $formatter"
      noFormatter
    ;;
  esac
}

# Global stuff to be generated.
formatter=`getFormatter`
