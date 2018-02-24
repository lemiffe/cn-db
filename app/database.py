import urllib.parse
import configparser
from pymongo import MongoClient


class Database:

    def __init__(self):
        # Read config
        config = configparser.ConfigParser()
        config.read('config.ini')
        print(config)
        self.db_name = config.get('mongo', 'db_name')
        self.user = urllib.parse.quote_plus(config['mongo']['db_user'])
        self.password = urllib.parse.quote_plus(config['mongo']['db_pwd'])
        self.host = 'localhost'
        self.port = int(config['docker']['docker_port'])

    def connect(self):
        client = MongoClient(self.host, self.port, username=self.user, password=self.password)
        db = client[self.db_name]
        # Test the connection
        db.collection_names()
        return db
