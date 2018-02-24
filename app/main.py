import sys
from database import *
from pymongo import errors


try:
    db_loader = Database()
    db = db_loader.connect()
except (errors.ServerSelectionTimeoutError, errors.PyMongoError, errors.ConnectionFailure) as inst:
    print("Can't connect to the Database: ", inst)
    sys.exit(1)

print(db.collection_names())

posts = db.test_collection

#db.create_collection(name)
#index_name = 'Datetime'
#if index_name not in myCollection.index_information():
##     myCollection.create_index(index_name, unique=True)

#>>> my_collection.create_index([("mike", pymongo.DESCENDING),
#...                             ("eliot", pymongo.ASCENDING)])

# Drop coll:
# c['mydatabase'].drop_collection('mycollection')

print('hi')

# TODO: Commands
# TODO: Empty database command (restart)
# TODO: Initial Fixtures + indexes
#   TODO: Index on unique email address and username
# TODO: Command to make user admin

# TODO: Upgrade scripts



'''
#Insert
post_id = col.insert(post)
print post_id
#Bulk Inserts
new_posts = [
        {'author': 'X',
         'text': 'Another post!',
         'tags': ['bulk', 'insert'],
         'count': 1,
         'date': datetime.datetime(2009, 11, 12, 11, 14)},
            {'author': 'eliot',
             'title': 'MongoDB is fun',
             'text': 'andpretty easy too!',
             'date': datetime.datetime(2009, 11, 10, 10, 45)}
            ]
print col.insert(new_posts)

#Find
print col.find_one()
print col.find_one({'author': 'X'})
print col.find_one({'author': 'Eliot'})
print col.find_one({'_id': post_id})
print col.find_one({'_id': str(post_id)}) #No result
print col.find_one({'_id': ObjectId(str(post_id))}) #Convert str to ObjectId
for post in col.find({'title': 'MongoDB is fun'}):
    print post
d = datetime.datetime(2009, 11, 12, 12)
for post in col.find({'date': {'$lt': d}}).sort('author'):
    print post

#Update
print col.update({'author': 'X'}, {'$inc': {'count': 1}}, multi=True)
for doc in col.find({'author': 'X'}):
    print doc

#FindAndModify
print col.find_and_modify({'author': 'X'}, {'$push': {'tags': 'modify'}}, new=True)

#Remove
col.remove({'author': 'X'})

#Counting
print col.count()
print col.find({'title': 'MongoDB is fun'}).count()
'''