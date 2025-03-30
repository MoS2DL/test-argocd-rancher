#!/usr/bin/env bash

# exit when any commands fails
set -e

new_ver=$1

echo "new version:" $new_ver

# Simulate release of the new docker images
docker tag nginx:1.23.3 mos2/nginx:$new_ver

# Push new version to docker hub
docker push mos2/nginx:$new_ver

# Create temporary directory
tmp_dir=$(mktemp -d)
echo $tmp_dir


# Clone GitHub repo
git clone git@github-local:mos2dl/test-argocd-rancher.git $tmp_dir

# echo "Current dir: $(pwd)"
# echo "ll : $(ls -la)"

# cd $tmp_dir/test-argocd-rancher
# echo "Current dir: $(pwd)"
# echo "ll : $(ls -la)"

# Update image tag
sed -i -e "s/mos2\/nginx:.*/mos2\/nginx:$new_ver/g" $tmp_dir/my-app/1-deployment.yaml

# Commit and push
cd $tmp_dir
git config --local user.name "Foo Bazess - With Jazz Hands..."
git config --local user.email "nobodies.buisness@foo.net"
git add .
git commit -m "Update image to $new_ver"
git push

# Remove temporary directory
rm -rf $tmp_dir
