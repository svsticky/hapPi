#!/usr/bin/env bash

##
## USAGE: ./scripts/get-authorized-keys.sh
##
## Script that retrieves all SSH public keys stored on GitHub for users
## belonging to an organisation.
##
## A personal access token is used to also retrieve keys stored for users
## without public organization membership, this token must be stored in
## ./.github-secret in the format `username:token`.
##

# Unofficial Bash strict mode
set -eEfuo pipefail

ORG=svsticky

if [ ! -f .github-secret ]; then
  echo "No GitHub secret stored, run authorized-github.sh first!"
  exit 1
fi

echo "Creating .new-authorized-keys."
echo "# {{ ansible_managed }}" > .new-authorized-keys

echo "Retrieving users."
USERS=$(curl -u $(cat .github-secret) https://api.github.com/orgs/$ORG/members | jq -r '.[].login')

for user in $USERS; do
  echo "Retrieving keys for $user..."
  echo "# Keys for $user" >> .new-authorized-keys
  curl https://api.github.com/users/$user/keys | jq -r '.[].key' >> .new-authorized-keys
done

echo "Updating authorized-keys template."

mv --backup=numbered .new-authorized-keys templates/home/pi/.ssh/authorized_keys.j2

echo "Done!"
