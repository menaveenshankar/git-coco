# git_coauthors
a simple git hook to add co-authors to commit message

* _prepare-commit-msg_ should be copied to each of the respective git repos i.e. \<git repo\>/.git/hooks  
  if its a submodule then it should be copied to \<git repo\>/.git/modules/\<module name\>/hooks
* run chmod +x prepare-commit-msg
* authors.txt should be in the parent directory of prepare-commit-msg hook. It should not have any empty lines. The authors should be in the following format:  
  \<initials\>: \<full name\>, \<email\>  
  a common domain is assumed. This can be configured in the script.
  
**NOTE** - if you amend a commit message during an interactive rebase then the coauthor prompt will pop up again even if you had added them before. This is intentional. However, if you only change file(s) and do not wish to change the commit message during an amend then use 
```git commit --amend --no-edit```
 
## configs
The following variables in the script should be configured by the user:
* **domain** - the domain of your organization. e.g. gmail.com
* **issue_url_base** - if you are using frameworks like jira or codebeamer for tracking tasks,
                       then you can set the base url. Only one issue number per commit is supported currently. However, more can be manually added by amending the commit.
* **use_issue_in_msg** - set it to False if issue number in commit message is not needed. Default is True.

## screenshots
* input prompt - enter initials. co-author initials which aren't found are printed.
![coauthor_input](coauthor_input.png)
* how the commit message looks like after input prompt
![commit_msg](commit_msg.png)
