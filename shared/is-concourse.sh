#!/bin/bash

set -e
ARGV_DIRECTORY="$1"
set -u

apk add --no-cache openssh > /dev/null

mkdir ~/.ssh
echo "$SSH_KEY" > ~/.ssh/id_rsa
chmod 0400 ~/.ssh/id_rsa
ssh-keyscan github.com >> ~/.ssh/known_hosts

unset SSH_KEY

pushd $ARGV_DIRECTORY

org=$(jq -r '.base_org' .git/.version)
repo=$(jq -r '.base_repo' .git/.version)

popd
pushd repo-config

echo STATHIS1 $org
echo STATHIS2 $repo

[[ "${org}" == "product-os" ]] && [[ "${repo}" == "balena-concourse" ]] && exit 0
exit 1