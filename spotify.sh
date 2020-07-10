#!/bin/bash
fileformat="{artist}/{album}/{track-name}.{output-ext}"
cd /mnt/d/Music/Download/
while :
do
clear

cat<<EOF
----------------------------------
       Spotify Downloader
----------------------------------
EOF
echo -n "Download Location: "
pwd | cut -c 13-
echo "Press E to Change Location	"
echo ""
read -p $'\e[5m\e[31mPaste Spotify URL\e[0m: ' url
if [[ $url =~ (track) ]]; then
		clear
		echo "------------------------------"
		echo "Downloading..."
		echo "------------------------------"
		echo ""
		spotdl --song $url --output-file $fileformat
		echo ""
		echo "------------------------------"
		echo "Press any key to continue"
		while [ true ] ; do
		read -t 3 -n 1
		if [ $? = 0 ] ; then
		break;
		else
			:
		fi
		done;
else
	if [[ $url =~ (playlist) ]];then
		clear
		echo "------------------------------"
		echo "Downloading..."
		echo "------------------------------"
		echo ""
		spotdl --playlist $url --write-to=./playlist.txt
		spotdl -l ./playlist.txt --output-file $fileformat
		rm playlist.txt
		echo ""
		echo "------------------------------"
		echo "Press any key to continue"
		while [ true ] ; do
		read -t 3 -n 1
		if [ $? = 0 ] ; then
		break;
		else
			:
		fi
		done;
	else
		if [[ $url =~ (album) ]];then
			clear
			echo "------------------------------"
			echo "Downloading..."
			echo "------------------------------"
			echo ""
			spotdl --album $url --write-to=./playlist.txt
			spotdl -l ./playlist.txt --output-file $fileformat
			rm playlist.txt
			echo ""
			echo "------------------------------"
			echo "Press any key to continue"
			while [ true ] ; do
			read -t 3 -n 1
			if [ $? = 0 ] ; then
			break;
			else
				:
			fi
			done;
		else
			if [[ $url =~ (artist) ]];then
				clear
				echo "------------------------------"
				echo "Downloading..."
				echo "------------------------------"
				echo ""
				spotdl --all-albums $url --write-to=./playlist.txt
				spotdl -l ./playlist.txt --output-file $fileformat
				rm playlist.txt
				echo ""
				echo "------------------------------"
				echo "Press any key to continue"
				while [ true ] ; do
				read -t 3 -n 1
				if [ $? = 0 ] ; then
				break;
				else
					:
				fi
				done;
			else
				if [[ $url =~ (e|E) ]];then
				clear
				cd /mnt/d/Music/Download/
				printf "Please select folder:\n"
				select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
				cd "$d"
				fi
			fi
		fi
	fi
fi
done;
