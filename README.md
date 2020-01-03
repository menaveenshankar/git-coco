# git_coauthors
If you shied away from collaborative coding just because you had to manually add co-authors,
then this script will definitely calm your nerves. A simple git hook (in python3) to easily add co-authors to a commit
message. It gets triggered automatically as soon as you hit ```git commit```.
Furthermore, adding issue/task/item number is also supported. Check out the screenshots!

## Setup
Adapt ```config``` in ```utils.py``` accordingly (see configs section). Then,
```
chmod +x install_githooks.sh
./install_githooks.sh <path-to-your-git-repo>
```
and you are good to go! The setup script symlinks the git hooks in this repo to the git repo where you wanna use the git
hooks, and also adds the scripts in this repo to ```$PATH```. Happy collaborative coding :)

### Scripts in $PATH
* **Autosuggest version** - Run ```git-coco``` or ```git-coco -m "<msg>"``` to see the hook in action. ```git-coco``` takes the same arguments as
```git commit```. With ```git-coco``` you can avail the cool autosuggest feature. Input can be either author's initials
 or their email ids.
 ![autosuggest_coauthor_input](screenshots/autosuggest.png)
* **Eidetic version** - If you forget to run ```git-coco``` and run ```git commit``` instead, then the autosuggest feature
will not work. However, you can still add the coauthors using initials only. Its eidetic because you gotta remember the initials! :D
![coauthor_input](screenshots/coauthor_input.png)
* **Add authors to database** - to update ```authors.txt``` run ```git-add-authors```. It takes a list of authors
in the format specified in ```authors.txt```. e.g. ```git-add-authors "NR: Natasha Romanoff, black-widow" "AC: Arthur Curry, aquaman"```. 
Only unique initials can be added. The script takes care of checking if the initials are unique.
  
**NOTE** - if you amend a commit message during an interactive rebase then the coauthor prompt will pop up again even if you had added them before. This is intentional. However, if you only change file(s) and do not wish to change the commit message during an amend then use 
```git commit --amend --no-edit```

### Issue number (additional feature)
If you are using frameworks like jira or codebeamer for tracking tasks, then you can also add the corresponding task/issue number
to the commit message. This can be done automatically if you name the branch ending with _issuexxxxx where xxxxx is the task number. However, if your branch name does not contain the issue number then you will be prompted to enter it manually. Check the screenshots for an overview.

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

## Tags
* **v1.0** - checkout this tag to just use the eidetic version, i.e., author initials based input
* **v2.0** - checkout this tag to use the autosuggest version