#!/bin/bash

if [ -z "${GIT_NAME}"  ]
then
    GIT_NAME="Git Name"
fi
if [ -z "${GIT_EMAIL}"  ]
then
    GIT_EMAIL="git_email@example.org"
fi

git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"

/bin/bash
