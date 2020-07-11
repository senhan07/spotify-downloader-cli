#!/bin/bash
fileformat="{artist}/{album}/{track-name}.{output-ext}"
cd /mnt/d/Music/Download/
check(){
	cat /mnt/d/Music/Download/
}
if grep -q 1 "/mnt/c/Users/losen/manual";
then
	mode=$'\e[32mEnable\e[0m'
	manual="-m"
else
	mode=$'\e[31mDisable\e[0m'
	manual=""
fi
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
echo -e "Manual Mode: ${mode}"
read -p $'\e[5m\e[31mPaste Spotify URL\e[0m: ' url
if [[ $url =~ (track) ]]; then
		clear
		echo "------------------------------"
		echo "Downloading..."
		echo "------------------------------"
		echo ""
		spotdl --song $url $manual --output-file $fileformat
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
					
					else
						if [[ $url =~ (m|M) ]];then	
							if grep -q 1 "/mnt/c/Users/losen/manual"
								then
									echo "0" > /mnt/c/Users/losen/manual
									/bin/bash /mnt/c/Users/losen/spotify.sh
								else
									echo "1" > /mnt/c/Users/losen/manual
									/bin/bash /mnt/c/Users/losen/spotify.sh
							fi
						fi
				fi
			fi
		fi
	fi
fi
done;
