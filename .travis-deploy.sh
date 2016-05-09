#!/bin/bash

set -o errexit -o nounset

TARGET="devel"

#if [ "$TRAVIS_BRANCH" != "master" ]; then
#  echo "Skipping build for branch $TRAVIS_BRANCH..."
#  exit 0
#fi

rev=$(git rev-parse --short HEAD)
mkdir deploy && cd deploy

git init
git config --global user.name "Cajus Pollmeier"
git config --global user.email "cajus@naasa.net"
git config --global push.default simple

git remote add upstream "https://$DEPLOY_KEY@github.com/cajus/travis-page-test.git"
git fetch upstream
git merge upstream/master

rm -rf "$TARGET" &> /dev/null
cp -a ../build "$TARGET"

#TODO: When we've some more control over the qx DNS records, we can add a CNAME here...
#echo "qooxdoo.org" > CNAME

touch .

git add -A .
git commit -m "Refresh site at ${rev}"
git push -q upstream HEAD:master
