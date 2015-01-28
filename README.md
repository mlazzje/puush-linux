Puush for Linux
=====================

Purpose
-------
This script will allow you to push on puush.me images
An unique link provided by puush.me will be pasted in your clipboard
You will be able to share this link to everyone

Dependencies
------------
	* gnome-screenshot	(take screenshot)
	* curl				(HTTP requests)
	* xclip				(clipboard)
	* notify-send 		(notifications)

Instructions
------------
	1. Get this script by cloning or download this repository
	2. Create an account here http://puush.me/register
	3. Add your puush API key to PUUSH_API_KEY in file "puush" line 7
	(Find your API key here at http://puush.me/account/setting)
	4. Make you file executable __chmod +x puush__
	5. Place it in "/usr/local/bin"

Usage
-----
``` bash
puush -a 				select area to puush
puush -d 				puush entire desktop
puush -f 				puush selected file //TODO
puush -w 				puush current window

puush -h, -?, --help 	show help page
```

Advice
------
You can add custom keyboard shortcuts on Ubuntu
![Custom keyboard shortcuts](http://puu.sh/faeyv/5826ed5586.png "Custom keyboard shortcut")

Alternatives
------------
- puush in command line https://github.com/blha303/puush-linux
- puush using keyboard https://github.com/sgoo/puush-linux
- puush ubuntu https://github.com/sunmockyang/puush-linux
