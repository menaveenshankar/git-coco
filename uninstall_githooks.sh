#!/bin/bash

## script to remove git hooks

if [ $# -ne 1 ]; then
	echo -e '\e[91mmissing argument - path to git repo\e[39m';
	exit
fi

# set paths
dir_path=$1
PWD=$(pwd)

# keep track of exit codes during removal
sum_exit_codes=0
function add_on_exit_code {
        if [ $? -ne 0 ]
        then
                sum_exit_codes=$(($sum_exit_codes+1))
        fi
}

# remove git hooks
rm ${dir_path}/authors.txt;
add_on_exit_code
rm ${dir_path}/prepare-commit-msg;
add_on_exit_code

if [ $sum_exit_codes -ne 0 ]
then
	echo -e '\e[91mCould not uninstall some symlinks!\e[39m';
else
	echo -e '\e[92mGit hooks uninstalled!\e[39m';
fi;