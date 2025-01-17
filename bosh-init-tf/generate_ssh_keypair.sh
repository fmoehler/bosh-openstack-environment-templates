#!/usr/bin/env bash
set -eu

green() {
  echo -e "\033[0;32m${@}\033[0m"
}

red() {
  echo -e "\033[0;31m${@}\033[0m"
}

# abort if a key pair already exists
[[ -e "bost-test.pem"     ]] && red "Found key. Aborting!" && exit 1
[[ -e "bost-test.pub" ]] && red "Found key. Aborting!" && exit 1

# create new key pair
ssh-keygen -t rsa -b 4096 -C "bosh" -N "" -f "bost-test.pem"
mv bost-test.pem.pub bost-test.pub

# finally inform user about successful completion
green "Key pair created successfully."