# git_coauthors
If you shied away from collaborative coding just because you had to manually add co-authors,
then this script will definitely calm your nerves. A simple git hook (in python3) to easily add co-authors to a commit
message. It gets triggered automatically as soon as you hit ```git-coco```.
Furthermore, adding issue/task/item number is also supported. Check out the screenshots!

# Table of Contents
* [Setup](#Setup)
* [How to use](#how-to)
* [Configs](#configs)
* [Available git tags](#version-tags)

## Setup
Adapt ```config``` in ```utils.py``` accordingly (see configs section). Then,
1. ```./setup_githooks.sh``` - installs dependencies and updates ```$PATH```.
2. ```githooks.sh install <absolute-path-to-your-git-repo>``` : this symlinks the 
git hooks in this repo to the git repo where you wanna use the git
hooks. **This step should be done for each repo where you wanna use the hook.**
```githooks.sh``` is in your ```$PATH```, so can be run from anywhere.

and you are good to go! Happy collaborative coding :)

### Uninstall
```githooks.sh uninstall <absolute-path-to-your-git-repo>```: removes the git hooks
from the repo.

## How-to
* ```git-coco``` (**Autosuggest version**): Run ```git-coco``` or ```git-coco -m "<msg>"``` to see the hook in action. ```git-coco``` takes the same arguments as
```git commit```. With ```git-coco``` you can avail the cool autosuggest feature. Input can be either author's initials
 or their email ids. **coco** is short for "**co**mmit **co**authors".
 ![autosuggest_coauthor_input](screenshots/autosuggest.png)
* **Eidetic version**: If you forget to run ```git-coco``` and run ```git commit``` instead, then the autosuggest feature
will not work. However, you can still add the coauthors using initials only. Its eidetic because you gotta remember all the initials! :D
![coauthor_input](screenshots/coauthor_input.png)
* ```git-add-authors```: to update ```authors.txt``` run ```git-add-authors```. It takes a list of authors
in the format specified in ```authors.txt```, i.e., ```<author-initials>: <author-full-name>, <author-email-id>```.
For example, ```git-add-authors "NR: Natasha Romanoff, black-widow" "KM: Krishna Mehra, krrish"```. 
Only unique initials can be added. The script takes care of checking if the initials are unique.

**NOTE** - if you amend a commit message during an interactive rebase then the coauthor prompt will pop up again even if you had added them before. This is intentional. However, if you only change file(s) and do not wish to change the commit message during an amend then use 
```git commit --amend --no-edit```

### Issue number (additional feature)
If you are using frameworks like jira or codebeamer for tracking tasks, then you can also add the corresponding task/issue number
to the commit message. This can be done automatically if you name the branch ending with _issuexxxxx where xxxxx is the task number.
*The fundamental principle of this feature is to encourage one branch per issue*.
However, if your branch name does not contain the issue number then you will be prompted to enter it manually. Check the screenshots for an overview.

## configs
The following variables under ```config``` in the script should be configured by the user:
* **authors_file** - ```authors.txt``` usually is project specific and should reside in the parent directory
                                   of hooks. However, if several projects share the author list then this path can be
                                   accordingly adjusted.
* **domain** - the domain of your organization. e.g. gmail.com
* **issue_url_base** - if you are using frameworks like jira or codebeamer for tracking tasks,
                       then you can set the base url. Only one issue number per commit is supported currently. However, more can be manually added by amending the commit.
* **use_issue_in_msg** - set it to False if issue number in commit message is not needed. Default is True.

##
How the final commit message looks like:
![commit_msg](screenshots/commit_msg.png)

**NOTE** - Coauthors and issue number are optional, the committer can simply hit enter to ignore them.

## Version Tags
Latest version is always the topmost tag in the following list:
* **v2.1** - single script to install/uninstall git hooks
* **v2.0** - added autosuggest version
* **v1.0** - checkout this tag to just use the eidetic version, i.e., author initials based input
