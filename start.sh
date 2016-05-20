#!/usr/bin/env bash

function usage {
cat << END

usage: $0 -e <git_commits_email> -u <git_commits_name>

Starts a python-dev-env container and deletes it on exit of the container.

Option: -e: git email in commits
Option: -u: git name in commits
END
}

OPTSTRING=":e:u:"

if [[ -z $@ ]]
then
	usage
	exit 1
fi
while getopts $OPTSTRING opt; do
	case $opt in
		e)
			GIT_EMAIL=$OPTARG
			;;
		u)
			GIT_NAME=$OPTARG
			;;
		\?)
			usage
			;;
		:)
      			echo "Option -$OPTARG requires an argument." >&2
      			exit 1
      			;;
	esac
done

HOST_FOLDER="$(pwd)"
docker run -ti --rm -e GIT_NAME="$GIT_NAME" -e GIT_EMAIL="$GIT_EMAIL" -v ${HOME}/.ssh:/root/.ssh -v ${HOST_FOLDER}:/Project python-dev-env
