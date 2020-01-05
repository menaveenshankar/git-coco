#!/bin/bash

# check if gitpython is installed
python -c "import git" &> /dev/null;
if [ $? -eq 1 ];
then
  echo "[INFO]: Installing gitpython";
  pip3 install gitpython;
fi

# check if prompt-toolkit is installed
python -c "import prompt_toolkit" &> /dev/null;
if [ $? -eq 1 ];
then
  echo "[INFO]: Installing prompt-toolkit";
  pip3 install prompt-toolkit;
fi

#check if PATH is updated in bashrc
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     bashrc_file=$HOME/.bashrc;;
    Darwin*)    bashrc_file=$HOME/.bash_profile;;
    *)          echo "[INFO]: Supported only on Linux and Mac. For other OSes carry out the following steps manually";;
esac

if [[ ! $PATH =~ ${PWD} ]]; then
  printf "\n#githooks to PATH\n" >> ${bashrc_file};
  printf "export PATH=\$PATH:$(pwd)\n" >> ${bashrc_file};
  printf "export GIT_COCO=$(pwd)\n" >> ${bashrc_file};
  echo "[INFO]: updated \$PATH. env var \$GIT_COCO points to $(pwd)"
fi

GIT_COCO=$(pwd)
## setup git hook and scripts
chmod +x ${GIT_COCO}/prepare-commit-msg
chmod +x ${GIT_COCO}/git-add-authors
chmod +x ${GIT_COCO}/git-coco
chmod +x ${GIT_COCO}/install_githooks.sh
chmod +x ${GIT_COCO}/uninstall_githooks.sh

if [ $? -ne 0 ]
then
	echo -e '\e[91mSetup failed!\e[39m';
else
	echo -e '\e[92mSetup succeeded! Install githooks after restarting terminal.\e[39m';
fi;
