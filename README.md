# git-coco (tool for adding co-authors)
If you shied away from collaborative coding just because you had to manually add co-authors,
then this script will definitely calm your nerves. `git-coco` is a simple git hook (in python3) to easily add co-authors to a commit
message. It gets triggered automatically as soon as you hit ```git-coco```. **coco** is short for "**co**mmit **co**authors".

Main features (TL; DR)-
* Run ```git-coco``` instead of ```git commit``` with the same arguments.
* Supports **Autcomplete** (keys - TAB, ↑, ↓) which relieves you of the mnemonic load of remembering author's
initials, and **Autosuggest** (key →) on top of this makes the process of adding repetitive 
co-author groups hassle free.
* Supports issue/task/item number as part of the commit message.

Check out the screenshots!

**Requirements** - To get started, all you need is a linux or mac computer with `bash` support. If you prefer other
shells (like `zsh`) then adapt `setup.sh` accordingly.

# Table of Contents
* [Setup](#Setup)
* [How to use?](#how-to-use)
    * [Issue number (additional feature)](#issue-number)
    * [When to skip the triggering of hooks](#skip-hooks)
* [Configs](#configs)
* [Available git tags](#version-tags)
* [Extendable interface for programmers](#extendable-interface)
* [Why git-coco?](#why-coco)
    * [Comparison to other co-author tools](#comparison-to-other-coauthor-tools)

## Setup
Adapt ```config``` in ```utils.py``` accordingly (see [Configs](#configs)). Then,
1. ```./setup.sh``` - installs dependencies, updates ```$PATH```, and adds an environment variable ```GIT_COCO```
to bashrc. Restart your terminal after this step.
2. ```coco.sh install <absolute-path-to-your-git-repo>``` : this symlinks the 
git hooks to the git repo where you wanna use them. **This step should be done for each repo where you wanna use the hook.**
```coco.sh``` is in your ```$PATH```, so can be run from anywhere.
3. Add authors you collaborate with using `git-add-authors`.

and you are good to go! Happy collaborative coding :)

I would recommend adding `alias gco="git-coco"` to your bashrc.


### Uninstall
```coco.sh uninstall <absolute-path-to-your-git-repo>```: removes the git hooks
from the repo.

## How to use
* ```git-coco``` (**Autocomplete version**): Run ```git-coco``` or ```git-coco -m "<msg>"``` to see the hook in action.
 ```git-coco``` takes the same arguments as
```git commit```. With ```git-coco``` you can avail the cool autocomplete feature. Input can be either author's initials
 or their email ids, just type few letters of the respective author(s) for the available options to pop-up. Multiple authors
 should be separated by comma. **Key bindings** - Select using ```TAB``` or ```up-arrow/down-arrow``` key.
 
 ![autosuggest_coauthor_input](screenshots/autosuggest.png)
 
  **Autosuggest** co-author groups - if a bunch of you work together frequently, then adding the same co-authors repeatedly from scratch is a hassle. You can make use
 of the autosuggest feature based on history to circumvent this. **Key bindings** - Select using ```right-arrow``` key.
 
  e.g. if Batman and Superman work together on multiple commits, then for the next commit you only need to type Batman. The autosuggest feature
 automatically suggests Superman which can be completed with the ```right-arrow``` key. The autosuggest feature works along with the above autocomplete
 feature.
 ![autosuggest_coauthor_input](screenshots/autosuggest_history.png)
 
* **Eidetic version**: If you forget to run ```git-coco``` and run ```git commit``` instead, then the autosuggest feature
will not work. However, you can still add the coauthors using initials only. Its eidetic because you gotta remember all the initials! :smiley:
![coauthor_input](screenshots/coauthor_input.png)
* ```git-add-authors```: to update ```authors.txt``` run ```git-add-authors```. It takes a list of authors
in the format specified in ```authors.txt```, i.e., ```<author-initials>: <author-full-name>, <author-email-id>```.
For example, ```git-add-authors "NR: Natasha Romanoff, black-widow" "KM: Krishna Mehra, krrish"```. 
Only unique initials can be added. The script takes care of checking if the initials are unique.

### Issue number
If you are using frameworks like jira or codebeamer for tracking tasks, then you can also add the corresponding task/issue number
to the commit message (check the screenshots). This can be done automatically if you **name the branch ending with _issuexxxxx** where xxxxx is the task number.
*The fundamental principle of this feature is to encourage one branch per issue*.
However, if your branch name does not contain the issue number then you will be prompted to enter it manually. This feature is an
example of how to add your own custom messages on top of co-authors (see for [Extendable interface](#extendable-interface) more details). 

### Skip hooks
In the following cases, you should skip triggering the hook-
* `rebase -i` - if you amend a commit message during an interactive rebase then the coauthor prompt will pop up again even if you had added them before. This is intentional. However, if you only change file(s) and do not wish to change the commit message during an amend then use 
```git commit --amend --no-edit```
* `cherry-pick` - ```git cherry-pick <hash>``` triggers ```git commit``` by default, which then triggers the hook. Use ```git cherry-pick -n <hash>``` to avoid that.



##
How the final commit message looks like:
![commit_msg](screenshots/commit_msg.png)

**NOTE** - Coauthors and issue number are optional, the committer can simply hit enter to ignore them.

## configs
<details>
<summary>The following variables under ```config``` in the script should be configured by the user: </summary>

### mutable (edit these)
* **domain** - the domain of your organization. e.g. gmail.com
* **issue_url_base** - if you are using frameworks like jira or codebeamer for tracking tasks,
                       then you can set the base url. Only one issue number per commit is supported currently. However, more can be manually added by amending the commit.
* **use_issue_in_msg** - set it to False if issue number in commit message is not needed. Default is True.

### immutable paths (preferably, edit only if necessary)
* **authors_file** - ```authors.txt``` usually is project specific and should reside in the parent directory
                                   of hooks. However, if several projects share the author list then this path can be
                                   accordingly adjusted.
* **coauthors_git_msg_file** - ```.coauthors.tmp``` is used to store the co-author message temporarily. This resides under the home directory.
* **history_file** - ```.git_coco_history``` is used to store the history of co-authors, resides under the home directory.
</details>


## Extendable Interface
<details>
<summary>If you want to add your own message type on top of coauthors (like the issue number) then, </summary>

1. simply add a custom class derived from ```CommitMessage``` in ```commit_message.py```.
You should override the property ```message``` which returns a string.
2. add a call to your custom class in ```fill_messages``` function in ```prepare-commit-msg```.
Your call should be under ```extend()``` at the appropriate place respecting the message format
as mentioned in the documenation of ```fill_messages```
3. Each custom class should have a flag variable under ```config``` in ```utils.py``` w.r.t useability. All config variables
 for this custom class should reside under its respective sub-dict, e.g., ```coauthors```, ```issue```.  
</details>

## Version Tags
<details>
<summary>Latest version is always the topmost tag in the following list:</summary>

* **v2.4** - restructured git-coco package, simple setup process
* **v2.3** - refactor code to have extendable interface for custom message types
* **v2.2** - autosuggest frequently occuring coauthor groups
* **v2.1** - single script to install/uninstall git hooks
* **v2.0** - added autocomplete version
* **v1.0** - checkout this tag to just use the eidetic version, i.e., author initials based input
</details>

## Why coco
Why not wrap it completely in `prepare-commit-msg` and just use vanilla git commit?
`git-coco` was born because the default hook environment provides a very minimal tty where cool features like
 autocomplete built on top of `prompt-toolkit` or even tab based completion using `readline` won't function.
Here are my queries regarding `tty` on [github](https://github.com/prompt-toolkit/python-prompt-toolkit/issues/1030) and 
[stackoverflow](https://stackoverflow.com/questions/59357934/autocomplete-does-not-work-within-git-hook-tty-problem).

### Comparison to other coauthor tools:
* Other co-author tools like `git-mob` and `git-pair` rely exclusively on author initials. As the number
of authors in the database increase, usability becomes an issue due to the mnemonic load (of remembering)
initials. Autocomplete in `git-coco` eliminates this issue. 
* Each commit in `git-coco` can have different set of co-authors which is not supported by `git-mob` and `git-pair`.
* `git-coco` is written in python3 and is simple to setup.
