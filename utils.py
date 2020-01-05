from os import getenv
from os.path import dirname, exists, join as join_path
import sys

config = {
    'coauthors': {
        'authors_file': join_path(dirname(__file__), 'authors.txt'),
        'coauthors_git_msg_file': join_path(getenv('HOME'), '.coauthors.tmp'),
        'domain': 'superhero.universe',
        'history': join_path(getenv('HOME'), '.git_coco_history')
    },
    'issue': {
        'issue_url_base': 'https://superhero-jira.net/',
        'use_issue_in_msg': True
    }
}


def author_details_as_dict(authors_details_list):
    return dict([x.split(':') for x in authors_details_list])


def read_authors_file_as_dict(authors_file):
    try:
        if not exists(authors_file):  raise IOError
        with open(authors_file, 'r') as f:
            contents = filter(lambda x: x.strip(), f.readlines())
        return author_details_as_dict(contents)

    except IOError:
        print('[ERROR]: authors.txt not found, check README!')
        sys.exit(1)
