#!/bin/sh
# Get the dependencies for the toolchain

commands="wget unzip lha make gcc java python3 pip3"
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

wget http://www.zimmers.net/anonftp/pub/cbm/crossplatform/graphics/Amiga/C64Gfx.lha
lha -x C64Gfx.lha
cd c64gfx/src
make

cd ../../..

pip3 install prg2xex

echo "Setting environment variables"
export KICK_HOME=./tools
export C64GFX_HOME=./tools/c64gfx

echo "Now install VICE for your system from http://vice-emu.sourceforge.net/index.html#download"
echo "and export VICE_HOME to point to your VICE install dir"
echo
echo "Now install Atari 800 mac X or similar: https://www.atarimac.com/atari800macx.php"