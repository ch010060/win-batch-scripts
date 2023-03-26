# Python program to illustrate the
# extraction of FLAC audio metadata
# using the mutagen module
import sys
# Importing the FLAC method
# from the mutagen module
from mutagen.flac import FLAC

# Check argc num
if len(sys.argv) != 3:
    print("Usage: "+sys.argv[0]+" "+"<FILE> <GENRE_VALUE>")
    sys.exit(1)

# Loading a flac file
filePath = sys.argv[1]
audio = FLAC(filePath)

# Adding tags to the metadata
GENRE_VALUE = sys.argv[2]

if ("GENRE=" in audio.pprint()) and (GENRE_VALUE in audio['GENRE']):
    GENRE_LIST = audio['GENRE']
    GENRE_LIST.remove(GENRE_VALUE)
    audio['GENRE'] = GENRE_LIST

    # Saving the changes
    audio.save()

# Printing all the metadata
#print(audio.pprint())