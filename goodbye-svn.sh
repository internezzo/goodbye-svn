#!/bin/bash

originalUrl=$1
repoName=$2
targetUrl=$3
svnUser=$4

git svn clone --stdlayout --no-metadata --no-minimize-url --authors-file svn_to_git_usernames.txt --prefix=svn/ --username $svnUser $originalUrl ${repoName}_tmp



# wait to manually create tags and branches
echo "Now go and add all the tags manually to the Git-Repository"
echo
read -p "Press ENTER to continue..."


# now clone again locally to remove all SVN references
git clone ${repoName}_tmp $repoName
cd $repoName
git remote rm origin
git remote add origin $targetUrl
git push -u origin master --tags