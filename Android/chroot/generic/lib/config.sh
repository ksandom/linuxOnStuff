# Config manager

function listConfigs
{
  ls "$crManagerHome"/config.d
}

function listConfigsWithDescriptions
{
  while read configName;do
    # Load stored config.
    . "$crManagerHome"/config/defaults
    . "$crManagerHome"/config.d/$configName
    
    # Derive parameters.
    crHome="$crManagerHome"/mnt/"$configName"
    crHomeWithoutMountPoint="$configName"
    
    # Display results.
    echo "$configName:$crDescription"
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
