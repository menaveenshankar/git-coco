# git_coauthors
If you shied away from collaborative coding just because you had to manually add co-authors, then this script will definitely calm your nerves. A simple git hook (in python3) to easily add co-authors to a commit message. It gets triggered automatically as soon as you hit ```git commit```. Furthermore, adding issue/task/item number is also supported. Check out the screenshots!

## Setup
```chmod +x setup.sh && ./setup.sh <path-to-your-git-repo>```,
and you are good to go! The setup script symlinks the git hooks in this repo to the git repo where you wanna use the git
hooks, and also adds the scripts in this repo to ```$PATH```
Run ```git commit``` or ```git commit -m "<msg>"``` to see the hook in action. Happy collaborative coding :)
  
**NOTE** - if you amend a commit message during an interactive rebase then the coauthor prompt will pop up again even if you had added them before. This is intentional. However, if you only change file(s) and do not wish to change the commit message during an amend then use 
```git commit --amend --no-edit```

### Issue number (additional feature)
If you are using frameworks like jira or codebeamer for tracking tasks, then you can also add the corresponding task/issue number
to the commit message. This can be done automatically if you name the branch ending with _issuexxxxx where xxxxx is the task number. However, if your branch name does not contain the issue number then you will be prompted to enter it manually. Check the screenshots for an overview.

**NOTE** - Coauthors and issue number are optional, the committer can simply hit enter to ignore them.

## configs
The following variables under ```config``` in the script should be configured by the user:
* **relative_path_authors_file** - ```authors.txt``` usually is project specific and should reside in the parent directory
                                   of hooks. However, if several projects share the author list then this path can be
                                   accordingly adjusted.
* **domain** - the domain of your organization. e.g. gmail.com
* **issue_url_base** - if you are using frameworks like jira or codebeamer for tracking tasks,
                       then you can set the base url. Only one issue number per commit is supported currently. However, more can be manually added by amending the commit.
* **use_issue_in_msg** - set it to False if issue number in commit message is not needed. Default is True.

## screenshots
* input prompt - enter initials. co-author initials which aren't found are printed.
![coauthor_input](screenshots/coauthor_input.png)
* how the commit message looks like after input prompt
![commit_msg](screenshots/commit_msg.png)
