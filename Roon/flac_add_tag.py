# Python program to illustrate the
# extraction of FLAC audio metadata
# using the mutagen module
import sys
# Importing the FLAC method
# from the mutagen module
from mutagen.flac import FLAC

# Check argc num
if len(sys.argv) != 4:
    print("Usage: "+sys.argv[0]+" "+"<FILE> <TAG_NAME> <TAG_VALUE>")
    sys.exit(1)

# Loading a flac file
filePath = sys.argv[1]
audio = FLAC(filePath)

# Adding tags to the metadata
TAG_NAME = sys.argv[2]
TAG_VALUE = sys.argv[3]
audio[TAG_NAME] = TAG_VALUE

# Saving the changes
audio.save()

# Printing all the metadata
# print(audio.pprint())