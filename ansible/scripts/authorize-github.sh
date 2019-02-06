#!/usr/bin/env bash

##
## USAGE: ./scripts/get-github.token.sh
##
## This is a script that requests a token for the Github API that can be used
## to read all members of the user's organizations, and stores it in a file in
## the current directory.
##

# Unofficial Bash strict mode
set -eEfuo pipefail

if [ -f .github-secret ]; then
  echo "There is already a token stored, remove .github-secret to request another one."
  exit 1
fi

# Note that bash cannot return strings, and instead redirects the stdout of
# commands called in the function to the caller.
function get_without_otp() {
  username=$1
  curl                                                    \
    -u $username                                          \
    --data '{"scopes":["read:org"],"note":"hapPI token"}' \
    https://api.github.com/authorizations
}

function get_with_otp() {
  username=$1
  otp=$2
  curl                                                    \
    -u $username                                          \
    -H "X-Github-OTP: $otp"                               \
    --data '{"scopes":["read:org"],"note":"hapPI token"}' \
    https://api.github.com/authorizations
}

echo "Please enter your Github username:"
read USERNAME

echo "Please enter an one-time password, if required, else just press enter."
read OTPCODE

if [ -n $OTPCODE ]; then
  echo "Requesting token with OTP code."
  HTTPRESULT=$(get_without_otp $USERNAME $OTPCODE)
else
  echo "Requesting token without OTP code."
  HTTPRESULT=$(get_without_otp $USERNAME)
fi

TOKEN_VALUE=$(echo $HTTPRESULT | jq -r '.token')

echo "Got token: $TOKEN_VALUE"

echo "$USERNAME:$TOKEN_VALUE" > .github-secret

echo "Token saved!"

# vim: et softtabstop=2 sw=2
