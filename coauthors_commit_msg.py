from time import sleep


class CoauthorsCommitMsg(object):
    def __init__(self, coauthors, authors_dict, config_coauthors):
        self._coauthors = self.non_empty_coauthors_list(coauthors)
        self._config = config_coauthors
        self.authors_dict = authors_dict

    def non_empty_coauthors_list(self, coauthors):
        valid_coauths = [x.strip().upper() for x in coauthors.split(',')]
        return list(filter(lambda x: x, valid_coauths))

    def prune_incorrect_coauthor_initials(self):
        authorlst = set(self.authors_dict.keys())
        commit_authors = set(self._coauthors)
        correct_coauthors = authorlst.intersection(commit_authors)
        incorrect_coauthors = commit_authors.difference(authorlst)
        if incorrect_coauthors:
            print("[INFO]: These initials are incorrect {}. \n Please check and add them manually\n".format(
                list(incorrect_coauthors)))
            sleep(2)
        return correct_coauthors

    def get_coauthor_name_email(self):
        self._coauthors = self.prune_incorrect_coauthor_initials()
        return [self.authors_dict[x.strip().upper()].split(',') for x in self._coauthors]

    @property
    def co_authors(self):
        if not self._coauthors:
            return '\n'
        else:
            prefix_str = 'Co-authored-by: {}'
            _coauth_fmt = lambda x: '{} <{}@{}>'.format(x[0].strip(), x[1].strip(), self._config['domain'])

            coauths_lst = self.get_coauthor_name_email()
            coauths_str = [prefix_str.format(_coauth_fmt(x)) for x in coauths_lst]
            # git expects co-authors after two blank lines
            return '\n\n' + '\n'.join(coauths_str) + '\n\n'
