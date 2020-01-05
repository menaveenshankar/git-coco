#!/bin/bash

if [ $# -ne 2 ]; then
	echo -e '\e[91m mandatory args: <install|uninstall> <absolute-path-to-your-git-repo> \e[39m';
	exit
fi

dir_path=$2

if [[ "$1" == "install" ]]; then

  # symlink git hooks
  ln -s ${GIT_COCO}/authors.txt ${dir_path}/.git/;
  ln -s ${GIT_COCO}/prepare-commit-msg ${dir_path}/.git/hooks/;

  if [ $? -ne 0 ]
  then
    echo -e '\e[91mCould not create some symlinks!\e[39m';
  else
    echo -e '\e[92mSymlinks created! Git hooks can be used now.\e[39m';
  fi;
fi;

if [[ "$1" == "uninstall" ]]; then
  # remove git hooks
  rm ${dir_path}/.git/authors.txt;
  rm ${dir_path}/.git/hooks/prepare-commit-msg;

  if [ $? -ne 0 ]
  then
    echo -e '\e[91mCould not uninstall some symlinks!\e[39m';
  else
    echo -e '\e[92mGit hooks uninstalled!\e[39m';
  fi;

fi;