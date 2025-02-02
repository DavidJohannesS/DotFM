#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 email@example.com"
  exit 1
fi

# Extract the username part before the @ from the email
USERNAME=$(echo "$1" | cut -d'@' -f1)

# Generate the SSH key
ssh-keygen -t ed25519 -C "$1" -f ~/.ssh/id_ed25519_$USERNAME

# Check if xclip is installed and copy the public key to the clipboard
if command -v xclip > /dev/null; then
  xclip -sel clip < ~/.ssh/id_ed25519_$USERNAME.pub
  echo "Public key copied to clipboard."
else
  cat ~/.ssh/id_ed25519_$USERNAME.pub
fi

