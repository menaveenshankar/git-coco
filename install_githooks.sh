#!/bin/bash

if [ $# -ne 1 ]; then
	echo -e '\e[91mmissing argument - path to git repo\e[39m';
	exit
fi

dir_path=$1

# symlink git hooks
ln -s ${GIT_COCO}/authors.txt ${dir_path}/.git/;
ln -s ${GIT_COCO}/prepare-commit-msg ${dir_path}/.git/hooks/;

if [ $? -ne 0 ]
then
	echo -e '\e[91mCould not create some symlinks!\e[39m';
else
	echo -e '\e[92mSymlinks created! Git hooks can be used now.\e[39m';
fi;