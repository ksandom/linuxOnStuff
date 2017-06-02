# For setting up a chroot.

function setupChroot
{
  copySupplimentaryScripts
  assertUserExists "$nonRootUser"
}

function copySupplimentaryScripts
{
  echo "Copy in supplimentary scripts for managing the chroot from the inside."
  supplimentaryDir="$crHome/usr/cr"
  mkdir -p "$crHome/usr/chroot"
  cp -v "$crManagerHome/supplimentary"/* "$crHome/usr/chroot"
  chmod 700 "$crHome/usr/chroot"/*.sh
}

function assertUserExists
{
  assertUser="$1"
  echo "Assert user $assertUser exists and set up sudo."
  runInCR "/usr/chroot/assertSudo.sh $assertUser"
}
