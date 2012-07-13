#!/bin/bash

# map the command line properties
originalUrl=$1
repoName=$2
targetUrl=$3
svnUser=$4

# clone from the SVN repository
git svn clone --stdlayout --no-metadata --no-minimize-url --authors-file svn_to_git_usernames.txt --prefix=svn/ --username $svnUser $originalUrl ${repoName}_tmp

cd ${repoName}_tmp


# strip out empty commits (e.g. from copying in SVN)
echo
echo
echo "now going to remove the empty commits from SVN copy actions"
git filter-branch --prune-empty --tag-name-filter cat -- --all



# create a tag for each SVN tag that would show up as a branch in Git
echo
echo
echo "now going to map all tags propperly..."
git for-each-ref --format="%(refname)" refs/remotes/svn/tags/ |
while read tag; do
	echo ${tag}
    GIT_COMMITTER_DATE="$(git log -1 --pretty=format:"%ad" "$tag")" \
    GIT_COMMITTER_EMAIL="$(git log -1 --pretty=format:"%ce" "$tag")" \
    GIT_COMMITTER_NAME="$(git log -1 --pretty=format:"%cn" "$tag")" \
    git tag -m "$(git for-each-ref --format="%(contents)" "$tag")" \
        ${tag#refs/remotes/svn/tags/} "$tag"
done
cd ..


# now clone again locally to remove all SVN references
git clone ${repoName}_tmp $repoName
cd $repoName
git remote rm origin
git remote add origin $targetUrl
git push -u origin master --tags