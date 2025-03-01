#!/bin/bash
echo "Running the launch_init.sh script"
echo "Hello, world"
cd ~
export PATH=${PATH}

pwd
echo ${PATH}:/opt/homebrew/bin

(source ~/.local/.initial/launch_term.sh ) &> ~/term.log