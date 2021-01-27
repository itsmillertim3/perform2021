# loggingScript.py

import logging
import threading
import random

# Create a custom logger
logger = logging.getLogger(__name__)

# Create handlers
f_handler = logging.FileHandler('file.log')

# Create formatters and add it to handlers
f_format = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
f_handler.setFormatter(f_format)

# Add handlers to the logger
logger.addHandler(f_handler)

# Set logging
logger.setLevel(logging.DEBUG)

def printit():
  threading.Timer(1.0, printit).start()
  a = random.randrange(120, 260, 2)
  if a < 145:
  	logger.error('Queue can not be processed for id %s',a)
  factorial = 1
  for x in range(0, random.randrange(1000000, 2000000, 2)):	
    factorial = factorial*x
  logger.info('Queue lenght is %s',random.randrange(60, 101, 2))

printit()