#!/bin/sh
set -e

# setup ssh-agent and provide the GitHub deploy key
eval "$(ssh-agent -s)"
chmod 600 deploy_rsa
ssh-add deploy_rsa

# This method depends on how you build your project.
# This is a node.js example:
# commit the assets in build/ to the gh-pages branch and push to GitHub using SSH

bundle install

./deploy.sh
