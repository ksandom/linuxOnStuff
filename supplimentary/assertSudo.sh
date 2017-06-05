# Tries to assert that sudo is installed.

function installSudoApt
{
  apt-get install sudo
}

function makeUserSudoable
{
  user="$1"
  
  if ! grep -q '^sudoers:' /etc/group; then
    echo "Adding group."
    groupadd sudoers
  fi
  
  if ! grep -q "^$user:" /etc/passwd; then
    echo "Adding user $user."
    useradd -m -s /bin/bash $user
    passwd "$user"
  fi
  
  if [ "`groups "$user" | grep -q sudoers`" == "" ]; then
    echo "Adding user $user to sudoers."
    gpasswd -a "$user" sudoers
    groups "$user"
  fi
  
  sudoersFile="/etc/sudoers.d/sudoers"
  if [ ! -e "$sudoersFile" ]; then
    echo "Building sudoers file."
    echo "%sudoers    ALL=(ALL:ALL) ALL" > "$sudoersFile"
    chmod 644 "$sudoersFile"
    if ! visudo -cf "$sudoersFile"; then
      echo "Sanity check failed. Removing config to prevent further failures. The config was:"
      cat "$sudoersFile"
      rm "$sudoersFile"
      exit 1
    fi
  fi
}

function assertSudo
{
  user="$1"
  
  if which apt-get > /dev/null; then
    installSudoApt
  fi
  
  makeUserSudoable "$user"
}

assertSudo "$1"
