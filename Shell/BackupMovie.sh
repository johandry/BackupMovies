#!/bin/bash

homeDir=`pwd`

#Movies Backup

iTunesDir="/Volumes/My Book/Shared iTunes/iTunes Media/Movies"
backupDir="/Volumes/Public/Shared Videos/Movies"


cd "$iTunesDir"
for m in */*; do echo ${m}; done > "$homeDir"/Movies_iTunesDir.txt
cd "$backupDir"
for m in */*; do echo ${m}; done > "$homeDir"/Movies_backupDir.txt
cd "$homeDir"

diff Movies_iTunesDir.txt Movies_backupDir.txt > Movies_toBackup.diff

moviesToBackup="$(grep '<' Movies_toBackup.diff)"
if [ ! -z "$moviesToBackup" ]; then
	echo
	echo "Movies to Backup:"
	echo "$moviesToBackup"
else
	echo;echo "No Movies to backup";echo
fi

moviesToDelete="$(grep '>' Movies_toBackup.diff)"
if [ ! -z "$moviesToDelete" ]; then
	echo
	echo "Movies to Delete"
	echo "$moviesToDelete"
fi

rm Movies_iTunesDir.txt 
rm Movies_backupDir.txt 
#rm Movies_toBackup.diff

#TV Show Backups
iTunesDir="/Volumes/My Book/Shared iTunes/iTunes Media/TV Shows"
backupDir="/Volumes/Public/Shared Videos/TV Shows"


cd "$iTunesDir"
for m in */*/*; do echo ${m}; done > "$homeDir"/TVShows_iTunesDir.txt
cd "$backupDir"
for m in */*/*; do echo ${m}; done > "$homeDir"/TVShows_backupDir.txt
cd "$homeDir"

diff TVShows_iTunesDir.txt TVShows_backupDir.txt > TVShows_toBackup.diff

TVShowsToBackup="$(grep '<' TVShows_toBackup.diff)"
if [ ! -z "$TVShowsToBackup" ]; then
	echo
	echo "TV Shows to Backup"
	echo "$TVShowsToBackup"
else
	echo;echo "No TV Shows to backup";echo
fi

TVShowsToDelete="$(grep '>' TVShows_toBackup.diff)"
if [ ! -z "$TVShowsToDelete" ]; then
	echo
	echo "TVShows to Delete"
	echo "$TVShowsToDelete"
fi

rm TVShows_iTunesDir.txt 
rm TVShows_backupDir.txt 
#rm TVShows_toBackup.diff