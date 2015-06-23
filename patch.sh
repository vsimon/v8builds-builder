#!/bin/bash
set -eo pipefail
set -x

# This patches a checkout

# win deps: find, sed
# lin deps: find, sed
# osx deps: find, gsed

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/environment.sh

usage ()
{
cat << EOF

usage:
   $0 options

Patch script.

OPTIONS:
   -h   Show this message
   -d   Top level build dir
EOF
}

while getopts :d: OPTION
do
   case $OPTION in
       d)
           BUILD_DIR=$OPTARG
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

pushd $BUILD_DIR

if [ $UNAME = 'Windows' ]; then
  echo "TBD"
else
  # linux and osx

  # sed
  if [ $UNAME = 'Darwin' ]; then
    SED='gsed'
  else
    SED='sed'
  fi

  pushd v8
  # patch the project to build standalone libs
  find . \( -name *.gyp -o  -name *.gypi \) -not -path *libyuv* -exec sed -i -e "s|\('type': 'static_library',\)|\1 'standalone_static_library': 1,|" '{}' ';'
  # for icu
  find . \( -name *.gyp -o  -name *.gypi \) -exec sed -i -e "s|\('type': '<(component)',\)|\1 'standalone_static_library': 1,|" '{}' ';'
  popd # v8
fi

popd
