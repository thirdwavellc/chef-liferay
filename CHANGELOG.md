liferay Cookbook Changelog
==========================

0.11.0
------
Adds initial Test Kitchen configuration
Updates Travis configuration
Bumps mysql-connector dependency

0.10.1
------
Removes enterprise/patch recipes from default
Adds support for additional Java Ops
Resolves permissions issues when loading patches

0.10.0
------
Adds basic CentOS support
Updates Travis configuration
Documentation updates

0.9.7
-----
Conditionally loads ext based on the node attribute

0.9.6
-----
Refactors database creation

0.9.5
-----
Fixes syntax error in attributes
Foodcritic cleanup

0.9.4
-----
Includes dependencies inside default recipe
Updates database boxes in Vagrantfile to use opscode provisionerless boxes

0.9.3
-----
Fixes postgres UTF8 encoding mismatch

0.9.2
-----
Moves to opscode provisionerless boxes with vagrant-omnibus for chef installation
Updates ROOT.xml default attributes

0.9.1
-----
Switches to more flexible ROOT.xml configuration

0.9.0
-----
Updates Berksfile to use github urls and a tag for mysql-connector
Conditionally loads ext until it can be refactored into its own recipe
Defines Liferay as a proper service, allowing it to be manipulated through notifications
Fixes bat file deletion
Adds attributes for setenv.sh configuration

0.8.4
-----
Updates mysql recipe to use the correct variables
Adds attributes for database name
Runs Liferay as its own user

0.8.3
-----
Updates mysql attributes to allow more control
Extracts Liferay to its home directory
Adds recipe for marketplace plugins
Updates enterprise license file ownership

0.8.2
-----
Refactors ext deployment
Whitespace cleanup
Updates ROOT.xml
Updates init script

0.8.1
-----
Adds default databases
Adds liferay aliases
Refactors plugins/patches to their own recipes
Updates Vagrantfile
Adds liferay shutdown commmand

0.8.0
-----
Adds database recipes with vagrant configurations

0.6.3
-----
Adds experimental liferay patching branch
Cleanup whitespace

0.6.2
-----
Adds placeholder for license
Fixes recipe name for enterprise

0.6.1
-----
Adds deploy directory for enterprise

0.6.0
-----
Adds basic enterprise recipe

0.5.0
-----
Adds metadata (first trackable version)
