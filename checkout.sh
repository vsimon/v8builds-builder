#!/bin/bash
set -eo pipefail
set -x

# This checks out a specific revision

# win deps: depot_tools
# lin deps: depot_tools
# osx deps: depot_tools

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/environment.sh

usage ()
{
cat << EOF

usage:
   $0 options

Checkout script.

OPTIONS:
   -h   Show this message
   -d   Top level build dir
   -r   Revision represented as a git tag version i.e. 4.5.73 (optional, builds latest version if omitted)
EOF
}

while getopts :d:r: OPTION
do
   case $OPTION in
       d)
           BUILD_DIR=$OPTARG
           ;;
       r)
           REVISION=$OPTARG
           ;;
       ?)
           usage
           exit 1
           ;;
   esac
done

if [ -z "$BUILD_DIR" ]; then
   usage
   exit 1
fi

if [ -z $REVISION ]; then
  # If no revision given, then get the latest revision from git ls-remote
  REVISION=`retry git ls-remote --tags $REPO_URL | cut -f 2 | sed 's#refs/tags/##' | grep '^[0-9]' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | tail -1`
fi

# gclient only works from the build directory
pushd $BUILD_DIR

# first fetch
fetch v8

# check out the specific revision after fetch
pushd v8
git checkout $REVISION
popd

popd
