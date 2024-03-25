from pymongo.server_api import ServerApi
from pymongo.mongo_client import MongoClient

class Connection():
    # Connection class
    # methods of this class are:
    # ['__init__', 'getConnection']

    def __init__(self):
        self.uri = "mongodb+srv://codergustavo:aUbvdptDUWGoNiue@barbeiro.aczkg8d.mongodb.net/?retryWrites=true&w=majority"
        self.client = MongoClient(self.uri, server_api=ServerApi('1'))
        return None

    def getConnection(self):
        return self.client["barbeiro"]

