#!/bin/sh

unset HISTFILE

if [ "$1" != "" ]; then
  HOST=$1
else
  echo Host?
  read HOST
fi

if [ "$2" != "" ]; then
  OLD_PASSWORD=$2
else
  echo Old Password?
  read OLD_PASSWORD
fi

if [ "$3" != "" ]; then
  NEW_PASSWORD=$3
else
  echo New Password?
  read NEW_PASSWORD
fi

HINT=""

# Connect to host
ssh -t admin@$HOST << 'EOSSH'

# Set hint for the admin user
dscl . -merge /Users/admin hint "$HINT"

# Set password for current user (admin)
passwd

# Set password for admin
#sudo dscl . -passwd /Users/admin "${NEW_PASSWORD}"

# Replace Keychain password
sudo security set-keychain-password -o "${OLD_PASSWORD}" -p "${NEW_PASSWORD}" /users/admin/Library/Keychains/login.keychain

EOSSH
