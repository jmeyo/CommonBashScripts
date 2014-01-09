#!/bin/bash

authorname=${1:-"ArtistName"}
audiobookname=${2:-"AudioBookName"}
year="2003"
path=$PWD
result=$path/"$authorname - $audiobookname"
i=1 

for cdname in `ls`
do 
	cd $cdname
		for file in `ls *.wav`
		do 
			id=`echo $file | sed 's/[^0-9]//g'`
			filename="${authorname} - ${audiobookname} - [$cdname] track $id"
			echo "convert ${file/.wav/}.wav to ${filename}.pcm ($i)"
			#mplayer -vc null -vo null -ao pcm:nowaveheader:fast:file="$filename.pcm" ${file/.wav/}.wav
			echo "convert ${file/.wav/}.pcm to ${file/.wav/}.m4b"
			faac -R 44100 -B 16 -C 2 -X -w -q 80 --artist "$authorname" --album "$audiobookname" --track "$i" --genre "Audiobooks" --year "$year" -o "${filename}.m4b" "${filename}.pcm"
			#mv "${filename}.m4b" "$result"
			i=$(($i + 1))
		done 
	cd ..
	echo "$cdname done"
done
