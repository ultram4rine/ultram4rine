#!/usr/bin/env bash

download() {
    wget https://github.com/yoheimuta/protolint/releases/download/v$1/protolint_$1_Linux_x86_64.tar.gz
    mkdir -p protolint && tar -xvf protolint_$1_Linux_x86_64.tar.gz -C protolint

    read -p "Remove protolint_$1_Linux_x86_64.tar.gz? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm protolint_$1_Linux_x86_64.tar.gz
    fi
}

if [[ $1 != "" ]]; then
    download $1
else
    version=$(curl --silent "https://api.github.com/repos/yoheimuta/protolint/releases/latest" |
        grep '"tag_name":' |
        sed -E 's/.*"([^"]+)".*/\1/' |
        sed -E '1s/^.//')

    download $version
fi
