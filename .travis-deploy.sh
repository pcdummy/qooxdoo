#!/bin/bash

set -o errexit -o nounset

#if [ "$TRAVIS_BRANCH" != "master" ]
#then
#  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
#  exit 0
#fi

rev=$(git rev-parse --short HEAD)
cd build

git init
git config --global user.name "Cajus Pollmeier"
git config --global user.email "cajus@naasa.net"
git config --global push.default simple

git remote add upstream "https://$DEPLOY_KEY@github.com/cajus/travis-page-test.git"
git fetch upstream
git reset upstream/master

#echo "qooxdoo.org" > CNAME

touch .

git add -A .
git commit -m "Refresh site at ${rev}"
git push -q upstream HEAD:master
