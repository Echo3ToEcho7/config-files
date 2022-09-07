#! /bin/sh
 
ORG=${2:-sunnyhaibin}
REPO=${3:-openpilot}
BRANCH=$1

DEFAULT_BRANCH="test-c3"

if [ -z $BRANCH ]; then
  echo -n "What branch do you want to update from? [$DEFAULT_BRANCH]: "
  read BRANCH_C

  BRANCH=${BRANCH_C:-$DEFAULT_BRANCH}
fi

cd /data

echo "Removing old OpenPilot"
rm -rf ./openpilot

echo "Cloning $ORG/$REPO:$BRANCH"
git clone -b $BRANCH --depth 1 --single-branch --recurse-submodules --shallow-submodules https://github.com/$ORG/$REPO.git openpilot
cd openpilot

echo "Done..."
echo -n "Reboot now? (y/[n]): "
read RB

if [ -n $RB ]; then
  if [ $RB = "y" ]; then
    echo "Rebooting..."
    sudo reboot
    exit 0 # Should never get here :)
  fi
  
  echo "Not rebooting"
fi
