# Config manager

function listConfigs
{
  ls "$crManagerHome"/config.d
}

function listConfigsWithDescriptions
{
  while read configName;do
    if [ ! -d "$crManagerHome/config.d/$configName" ]; then
      # Load stored config.
      . "$crManagerHome"/config/defaults
      . "$crManagerHome"/config.d/$configName
      
      # Derive parameters.
      crHome="$crManagerHome"/mnt/"$configName"
      crHomeWithoutMountPoint="$configName"
      
      # Display results.
      echo "$configName:$crDescription"
    fi
  done < <(listConfigs) | formatOutput
}

function setConfigContext
{
  configName="$1"
  
  # Load stored config.
  . "$crManagerHome"/config/defaults
  . "$crManagerHome"/config.d/$configName
  
  # Derive parameters.
  crHome="$crManagerHome"/mnt/"$configName"
  crHomeWithoutMountPoint="$configName"
  
  # Do stuff.
  echo "configName=$configName crDescription=\"$crDescription\""
  chooseOption "$2" "$3"
}
