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

How to use it?
--------------

Just clone this repository to a working directory of your choice. This will bring you a shell script to migrate your stuff to Git. Please make sure that the disk with your working directory has enough space for the repository to migrate as it will get checked out *twice* into your working copy!

	git@github.com:internezzo/goodbye-svn.git
	./goodbye-svn.sh <SVN-URL> <nameOfTheProject> <targetGitURL> <SVNUserName>

An example:

	./goodbye-svn.sh http://svn.example.org/my_projects/project_a/ project_a ssh://git@git.example.org/my-projects/project_a johndoe

The SVN username will be used to get the content out of the SVN repo, the source and target URLs are obviously used to know where to get it from and where to push to and the project name, well just for convenience of the developer of the shell script :-)