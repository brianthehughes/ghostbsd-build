#!/bin/sh

echo "##############################"
echo "## Build UNSTABLE ?          #"
echo "##"
echo "## Ctrl-C to stop            #"
read -p "Press enter to continue   # " reply
echo "##"
./build.sh -d mate -b unstable
./build.sh -d xfce -b unstable
./build.sh -d gx -b unstable
echo "###############################"
echo "## Build RELEASE ?            #"
echo "##"
echo "## Ctrl-C to stop             #"
read -p "## Press enter to continue   # " reply
echo "##"
echo "###############################"
echo "## Building RELEASE"
echo "##"
./build.sh -d mate
./build.sh -d xfce
./build.sh -d gx
