from abc import ABC


class CommitMessage(ABC):
    def __init__(self):
        self.message = ""
