#!/bin/bash
echo "Running the launch_init.sh script"
echo "Hello, world"
cd ~
export PATH=${PATH}


pwd
echo ${PATH}:/opt/homebrew/bin

#open /System/Applications/Utilities/Terminal.app \
#   /Users/mark/Packages/install/bin/ked ~/README.txt

PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH

wezterm start

sleep 10
