#!/usr/bin/env bash

#
# init.sh
#
# A script to initialize the Terraform remote state configuration settings.
# You'll want to run this every time you change AWS profiles but want to deploy
# this directory's Terraform environment.
#
# This is a special version of this script for the global settings, so it is
#  not specific to any particular environment.

##### Constants

# ENV_DIR should be "global"
readonly ROOT_DIR=${PWD##*/}
readonly CTINDEL_BUCKET="ctindel"

##### Functions

##### Main

if [[ $ROOT_DIR != "tf" ]]; then
    printf '\nERROR: This script can only be run from the tf directory'
    exit 1
fi

# clear out any existing local state
[[ -d .terraform ]] && rm -rf .terraform

terraform init

terraform get -update

if [[ $? -ne 0 ]]; then
    printf '\nMake sure any $AWS_ variables you currently have exported match the chosen profile!\n'
    exit 1
fi
