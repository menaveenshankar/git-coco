from os import getenv
from os.path import dirname, exists, join as join_path
import sys

config = {
    'path_authors_file': join_path(dirname(__file__), 'authors.txt'),
    'domain': 'superhero.universe',
    'issue_url_base': 'https://superhero-jira.net/',
    'use_issue_in_msg': True,
    'coauthors_git_msg': join_path(getenv('HOME'), '.coauthors.tmp')
}


def author_details_as_dict(authors_details_list):
    return [x.split(':') for x in authors_details_list]


def read_authors_file(authors_file):
    try:
        if not exists(authors_file):  raise IOError
        contents = open(authors_file, 'r').readlines()
        authors = author_details_as_dict(contents)
        return dict(authors)
    except IOError:
        print('[ERROR]: authors.txt not found, check README!')
        sys.exit(1)