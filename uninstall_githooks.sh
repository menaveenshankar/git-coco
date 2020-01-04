#!/bin/bash

## script to remove git hooks

if [ $# -ne 1 ]; then
	echo -e '\e[91mmissing argument - path to git repo\e[39m';
	exit
fi

# set paths
dir_path=$1
PWD=$(pwd)

# remove git hooks
rm ${dir_path}/.git/authors.txt;
rm ${dir_path}/.git/hooks/prepare-commit-msg;

if [ $? -ne 0 ]
then
	echo -e '\e[91mCould not uninstall some symlinks!\e[39m';
else
	echo -e '\e[92mGit hooks uninstalled!\e[39m';
fi;