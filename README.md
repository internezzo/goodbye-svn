Say Goodbye to SVN -> NOW
=========================

For what is this script?
------------------------

Given you have an SVN repository with directories for each sub-project that you now want to migrate (one-time!) to Git and leave Subversion behind afterwards. Often there is a global SVN repo-layout as following that is used:

	project_a
		branches
		tags
		trunk
	project_b
		branches
		tags
		trunk

Now in a usual Git configuration, you'll have a separate repository for each project. So it's now migration time - and goodbye SVN time!

Before using the script, make sure that

- you have access to both your SVN repositories and the target Git-Repositories (e.g. proper SSH-Setup, passwords at hand, ...)
- you have your target Git-Repositories created already
- you use the script on a real computer running either Linux or some flavor of UNIX like MacOS (Performance on Windows was **very** poor...)

What does it do?
----------------

After getting all the code (versions) out of the SVN repository, the following steps will be done automagically:

- after the initial clone from SVN, there will be some "empty" commits that do not change the content at all (mostly from copying stuff around in SVN, e.g. when tagging), these will be stripped out
- then all the tags from SVN will need to be converted to real Git-Tags
- after all that cleanup, the whole repository is (locally) cloned again to strip-off all the SVN references
- the last step then is to automaticall prepare the remote and push to that new remote right away

What does it NOT do?
--------------------

The script was a big help for us, but of course it has some limitations:

- During our migration, we found out that (of course), it doesn't fix all the mistakes that might have been done in the past. For example SVN repos without proper tags/branches/trunk structure -> pay attention to those and take care of the problem
- It does not really treat the SVN branches that might be around - but since we didn't really use them, we just ignored the branches

How to use it?
--------------

Just clone this repository to a working directory of your choice. This will bring you a shell script to migrate your stuff to Git. Please make sure that the disk with your working directory has enough space for the repository to migrate as it will get checked out **twice** into your working copy!

	cd to/your/working/directory
	git clone git@github.com:internezzo/goodbye-svn.git .

Now before you call the script, create a file named "svn_to_git_usernames.txt", which contains a row for each SVN-Committer in the following form

	username = Firstname Lastname <alias@example.org>

Then you're ready to launch:

	./goodbye-svn.sh <SVN-URL> <nameOfTheProject> <targetGitURL> <SVNUserName>

An example:

	./goodbye-svn.sh http://svn.example.org/my_projects/project_a/ project_a ssh://git@git.example.org/my-projects/project_a johndoe

The SVN username will be used to get the content out of the SVN repo, the source and target URLs are obviously used to know where to get it from and where to push to and the project name, well just for convenience of the developer of the shell script :-)

Credits:
--------

Parts of the code taken from [a tutorial](http://thomasrast.ch/git/git-svn-conversion.html) written by [Thomas Rast](http://thomasrast.ch/) - thanks for sharing!

Feedback:
---------
Feedback on the script is welcome! Just send it to info@internezzo.ch - or drop us a postcard, we'll be happy to hang it to our kitchen-wall in the office!