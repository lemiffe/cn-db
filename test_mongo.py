# Note: Python 2.7+

from pymongo import MongoClient
from urlparse import urlparse
import ConfigParser

# Read config
config = ConfigParser.RawConfigParser()
config.read('config.ini')

# Get config variables
user_raw = config.get('mongo', 'db_user')
pwd_raw = config.get('mongo', 'db_pwd')
db_name = config.get('mongo', 'db_name')

# Connect to MongoDB
user = urlparse(user_raw).path
pwd = urlparse(pwd_raw).path
client = MongoClient('localhost', 27017, username=user, password=pwd)
db = client[db_name]
posts = db.test_collection

# Run a quick test (to verify no auth issues)
print('count of entries in ' + db_name + '.test_collection:')
print(posts.count())