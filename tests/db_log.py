import logging
import time
logging.basicConfig(filename="test.log", level=logging.DEBUG)
logging.basicConfig(filename="test_error.log", level=logging.ERROR)




class TestClass():
    def __init__(self,name,price):
        self.name = name
        self.price = price
        logging.debug("Pizza created  {} : {} (${})".format(self.name, self.price,time.ctime()))



    def eat(self, quantity=1):
        logging.debug("Ate {} pizza(s)".format(quantity, self.name))

try:
    x = TestClass()
except Exception as e:
    logging.error("Pizza creation has TROUBLE OBJECT EXITED WITH CODE 1")
