#!/bin/sh

echo "##############################"
echo "## Build UNSTABLE"
echo
./build.sh -d mate -b unstable
./build.sh -d xfce -b unstable
./build.sh -d gx -b unstable

echo "##############################"
echo "## Build RELEASE ?"
echo
while true; do
    read -p "Build release? " yn
    case $yn in
      [Nn]* ) exit;;
      [Yy]* ) read -p "Did you update RELEASE in build.sh? " yn
      case
        [Nn]* ) exit;;
        [Yy]* ) break;;
      esac

    esac
done
echo "###############################"
echo "## Building RELEASE"
echo
./build.sh -d mate
./build.sh -d xfce
./build.sh -d gx
