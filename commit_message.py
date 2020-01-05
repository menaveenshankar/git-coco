from abc import ABC


class CommitMessage(ABC):
    def __init__(self):
        self.message = ""


class CoauthorsCommitMessage(CommitMessage):
    def __init__(self):
        super(CoauthorsCommitMessage, self).__init__()


class IssueNumberCommitMessage(CommitMessage):
    def __init__(self):
        super(IssueNumberCommitMessage, self).__init__()
