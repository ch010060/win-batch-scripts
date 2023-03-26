# Python program to illustrate the
# extraction of FLAC audio metadata
# using the mutagen module
import sys
# Importing the FLAC method
# from the mutagen module
from mutagen.flac import FLAC

# Check argc num
if len(sys.argv) != 3:
    print("Usage: "+sys.argv[0]+" "+"<FILE> <Date>")
    sys.exit(1)

# Loading a flac file
filePath = sys.argv[1]
audio = FLAC(filePath)

# Adding tags to the metadata
DATE = sys.argv[2]
audio['DATE'] = DATE

# Saving the changes
audio.save()

# Printing all the metadata
#print(audio.pprint())