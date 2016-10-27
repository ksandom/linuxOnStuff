#!/bin/bash
# Fix the permissions for the default user.

uid=$1

if [ "$1" == "" ]; then
	echo "Please specify a UID."
	exit 1
fi

groupadd -g $uid me
useradd -u $uid -g $uid me
 
