from pymongo import MongoClient
from urllib import parse as urlparse
import configparser
config = configparser.ConfigParser()
config.read('config.ini')

user = urlparse.quote_plus(config['mongo']['db_user'])
pwd_raw = config['mongo']['db_pwd']
pwd = urlparse.quote_plus(pwd_raw)
client = MongoClient('localhost', 27017, username=user, password=pwd)

db = client[config['mongo']['db_name']]

posts = db.test_collection

print('count of entries in ' + config['mongo']['db_name'] + '.test_collection:')
print(posts.count())