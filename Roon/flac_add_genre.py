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

## For Soundtrack
if GENRE_VALUE == "Soundtrack":
    if "GENRE=" not in audio.pprint():# Init GENRE
        audio['GENRE'] = GENRE_VALUE
        #print(audio['GENRE'])
        
        # Saving the changes
        audio.save()
    elif GENRE_VALUE not in audio['GENRE']:
        GENRE_LIST = audio['GENRE']
        GENRE_LIST.append(GENRE_VALUE)
        audio['GENRE'] = GENRE_LIST
        #print(audio['GENRE'])
        
        # Saving the changes
        audio.save()

## For Anime
if GENRE_VALUE == "Anime":
    if "GENRE=" not in audio.pprint():# Init GENRE
        audio['GENRE'] = GENRE_VALUE
        #print(audio['GENRE'])
        
        # Saving the changes
        audio.save()
    elif ("Soundtrack" not in audio['GENRE']) and (GENRE_VALUE not in audio['GENRE']):
        GENRE_LIST = audio['GENRE']
        GENRE_LIST.append(GENRE_VALUE)
        audio['GENRE'] = GENRE_LIST
        #print(audio['GENRE'])
        
        # Saving the changes
        audio.save()

## For Game
if GENRE_VALUE == "Game":
    if "GENRE=" not in audio.pprint():# Init GENRE
        audio['GENRE'] = GENRE_VALUE
        #print(audio['GENRE'])
        
        # Saving the changes
        audio.save()
    elif ("Soundtrack" not in audio['GENRE']) and (GENRE_VALUE not in audio['GENRE']):
        GENRE_LIST = audio['GENRE']
        GENRE_LIST.append(GENRE_VALUE)
        audio['GENRE'] = GENRE_LIST
        #print(audio['GENRE'])
        
        # Saving the changes
        audio.save()


# Printing all the metadata
#print(audio.pprint())