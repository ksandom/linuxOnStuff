# Config manager

function listConfigs
{
  ls -1 "$crManagerHome"/config.d
}

function listConfigsWithDescriptions
{
  while read configName;do
    . "$crManagerHome"/config.d/$configName
    echo "$configName:$crDescription"
  done < <(listConfigs) | column -t -s:
}

function setConfigContext
{
  configName="$1"
  . "$crManagerHome"/config.d/$configName
  echo "configName=$configName crDescription=\"$crDescription\""
  chooseOption "$2" "$3"
}
