#!/bin/sh
# Get the dependencies for the toolchain

commands="wget unzip make java python3 pip3"
for i in $commands
do
  if command -v $i > /dev/null; then
    echo "Found:$i"
  else
    echo "Could not find:$i aborting"
    exit 1
  fi
done

if [ -d "tools" ]; then
  echo "tools directory exists - exiting"
  exit 1
fi

mkdir tools
cd tools
wget http://www.theweb.dk/KickAssembler/KickAssembler.zip
unzip KickAssembler.zip
wget https://github.com/AppleCommander/AppleCommander/releases/download/v1-5-0/AppleCommander-ac-1.5.0.jar

wget  https://github.com/tom-seddon/beeb/archive/master.zip
unzip master.zip
cd ..

pip3 install prg2xex

echo "Setting environment variables"
export KICK_HOME=./tools
export AC_HOME=./tools
export BEEB_HOME=./tools/beeb-master
