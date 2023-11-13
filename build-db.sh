#!/usr/bin/env bash
#
# Script name: build-db.sh
# Description: Script for rebuilding the database for dtos-core-repo.
# GitLab: https://www.gitlab.com/dwt1/dtos-core-repo
# Contributors: Derek Taylor

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

x86_pkgbuild=$(find ../calamares/x86_64 -type f -name "*.pkg.tar.zst*")

#for x in ${x86_pkgbuild}
#do
#    mv "${x}" /calamares/x86_64/
#    echo "Moving ${x}"
#done

echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64
cd x86_64
rm -f aveos-repo*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
repo-add -s -n -R aveos-repo.db.tar.gz *.pkg.tar.zst

# Removing the symlinks because GitLab can't handle them.
rm aveos-repo.db
#rm aveos-repo.db.sig
rm aveos-repo.files
#rm aveos-repo.files.sig

# Renaming the tar.gz files without the extension.
mv aveos-repo.db.tar.gz aveos-repo.db
#mv aveos-repo.db.tar.gz.sig aveos-repo-db.sig
mv aveos-repo.files.tar.gz aveos-repo.files
#mv aveos-repo.files.tar.gz.sig aveos-repo.files.sig

echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"
