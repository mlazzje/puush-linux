#!/bin/bash
# 	@title: Puush linux
# 	@owner: mlazzje
# 	@date: 	January 2015

# Set puush API Key here
PUUSH_API_KEY="F2C703F2BACE24008A8BBF1052DFE954"
 
# Purpose:
#	This script will allow you to push on puush.me images
#	An unique link provided by puush.me will be pasted in your clipboard
#	You will be able to share this link to everyone
#
# Dependencies:
# 	gnome-screenshot	(take screenshot)
# 	curl				(HTTP requests)
# 	xclip				(clipboard)
# 	notify-send 		(notifications)
# 	zenity 				(file selector)
#
# Please install packages above before to run this script
#
# Licence: 
#	Beerware
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <mlazzje> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return. mlazzje
# ----------------------------------------------------------------------------
#
# Instructions:
# 	Create an account here http://puush.me/register
# 	Add your puush API key to PUUSH_API_KEY 
#	(You can find your API key at http://puush.me/account/settings)
#
# Usage: puush [OPTION...] [FILE-PATH]
#
# 	Options:
# 		-a 				select area to puush
#		-d 				puush entire desktop
#		-f 				puush specific file
#		-w 				puush current window
#
#		-h, -?, --help 	show help page
#
# 	File-Path:
#		<file-path> 	optional: path of file to puush
#						used without option
#
# Advice:
# 	Set up keyboard shortcuts

# print help page
function helpPage ()
{
	printf "Usage: puush [OPTION...] [FILE-PATH]\n"
	printf "\n"
	printf "  Options:\n"
	printf "	-a 		select area to puush\n"
	printf "	-d 		puush entire desktop\n"
	printf "	-f 		puush specific file\n"
	printf "	-w 		puush current window\n"
	printf "\n"
	printf "	-h, -?, --help 	show help page\n"
	printf "\n"
	printf "  File-Path:\n"
	printf "	<file-path> 	optional: path of file to puush\n"
	printf "			used without option\n"
	printf "\n"
	printf "Dependencies:\n"
	printf "\n"
	printf "	gnome-screenshot	(take screenshot)\n"
	printf "	curl 			(HTTP requests)\n"
	printf "	xclip 			(clipboard)\n"
	printf "	notify-send 		(notifications)\n"
	printf "	zenity 			(file selector)\n"
	printf "\n"
	printf "Please install packages above before to run this script\n"
	printf "\n"
	printf "Don't forget to create an account here http://puush.me/register\n"
	printf "Don't forget to provide your puush API KEY in script line 7\n"
	printf "\n"
	printf "Report bugs to ml@zzje.fr\n"
}

# without option puush direct file passed in argument
function puushFile ()
{
	if [ -z "$1" ]; then # if null
		echo "No file specified"
		helpPage
		exit 1
	elif [ ! -f "$1" ]; then # if not a file
		echo "Puush cancelled"
		helpPage
		exit 1
	fi

	# push file and retrieve response formatted like this 
	# 
	# 0,http://puu.sh/*****/**********.png,142424242,280
	#
	# - response (0) 
	#		0 	success
	#		-1 	failure upload
	#		-2 	failure no filename header
	# - url (http://puu.sh/*****/**********.png)
	# - id (142424242)
	# - size (280)
	# 
	# sed allow to get puush direct link to image
	fileURL=`curl "https://puush.me/api/up" -# -F "k=$PUUSH_API_KEY" -F "z=poop" -F "f=@$1" | sed -E 's/^.+,(.+),.+,.+$/\1\n/'`

	if [ ! -z "$fileURL" ]; then
		#Copy link to clipboard, show notification
		echo $fileURL
		printf $fileURL | xclip -selection "clipboard"
		notify-send -t 2000 "puush done! ->" "$fileURL"
	fi
}

# Generate filemane in tmp folder
function generateFileName () { 
	echo "/tmp/puush-$(date +"%Y-%m-%d_%I:%M:%S").png"; 
}

# check if API KEY provided
function checkConfig () {
	if [ -z "$PUUSH_API_KEY" ]; then

		echo "Set the variable PUUSH_API_KEY in $0"
		echo "Don't forget to create an account here http://puush.me/register"
		echo "You can find your API key at http://puush.me/account/settings"

		notify-send "Set the variable PUUSH_API_KEY in $0 line 7" "Find your API key at http://puush.me/account/settings"

		exit 1

	fi
	exit 0
}

# main function
function main () {
	fileName=$(generateFileName)
	# switch to check parameter
	case "$1" in
		-a)
			echo "Area puush"
			gnome-screenshot -a -f "$fileName"
			puushFile "$fileName"
			;;

		-d)
			echo "Desktop puush"
			gnome-screenshot -f "$fileName"
			puushFile "$fileName"
			;;

		-f)
			echo "File upload puush"
			puushFile "$fileName"
			;;

		-w)
			echo "Window puush"
			gnome-screenshot -w -f "$fileName"
			puushFile "$fileName"
			;;

		-h|-\?|--help)
			helpPage
			exit 0
			;;
			
		*)
			echo "Upload $1"
			puushFile "$1"
			;;	
	esac
}

# check if config it's ok, then execute main
if [ checkConfig ]; then
	main $1
fi