#!/usr/bin/env bash

download() {
    wget https://github.com/protocolbuffers/protobuf/releases/download/v$1/protoc-$1-linux-x86_64.zip
    unzip protoc-$1-linux-x86_64.zip -d ~/protoc/

    read -p "Remove protoc-$1-linux-x86_64.zip? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm protoc-$1-linux-x86_64.zip
    fi
}

if [[ $1 != "" ]]
then
    download $1
else
    version=$(curl --silent "https://api.github.com/repos/protocolbuffers/protobuf/releases/latest" |
        grep '"tag_name":' |
        sed -E 's/.*"([^"]+)".*/\1/' |
        sed -E '1s/^.//')

    download $version
fi
