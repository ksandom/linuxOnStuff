# Stuff to make things esier.

function installConvenience
{
  cp -v "$crManagerHome/bin/cr.linux"  "$crManagerHome/mnt/$configName/usr/bin/cr"
  chmod 755 "$crManagerHome/mnt/$configName/usr/bin/cr"
}

function uninstallConvenience
{
  rm -f "$crManagerHome/mnt/$configName/usr/bin/cr"
}
