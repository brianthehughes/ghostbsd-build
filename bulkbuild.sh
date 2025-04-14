#!/bin/sh

echo "##############################"
echo "## Build UNSTABLE ?          #"
echo "##                           #"
echo "## Ctrl-C to stop            #"
# read -p "Press enter to continue      # " reply
echo "##                           #"
echo "##############################"
echo "## Building UNSTABLE"
echo "##"
./build.sh -d mate -b unstable
./build.sh -d xfce -b unstable
./build.sh -d gx -b unstable
./build.sh -d lxqt -b unstable

exit

# Unstable Only

echo "###############################"
echo "## Build RELEASE ?            #"
echo "##                            #"
echo "## Ctrl-C to stop             #"
# read -p "## Press enter to continue    # " reply
echo "##                            #"
echo "###############################"
echo "## Building RELEASE"
echo "##"
./build.sh -d mate -b release
./build.sh -d xfce -b release
./build.sh -d gx -b release
./build.sh -d lxqt -b release

