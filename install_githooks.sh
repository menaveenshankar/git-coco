#!/bin/bash
pip3 install gitpython
export $PATH=$PATH:$(pwd)
ln -s $(pwd)/prepare-commit-msg $1/.git/hooks