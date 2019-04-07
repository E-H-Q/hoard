#!/bin/bash

view() {
	for file in *
	do (
		out=`ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0"` # finds video length (in seconds)
		int=${out%.*} # converts the floating point to an integer
		echo $int >> ~/data.txt # saves output numbers into a file
		echo "$file - $int"
	)
	done
}

check() {
	if [ -d "$dir" ]
	then
		cd "$dir"
		pwd
		main
	else
		view
	fi
}

main() {
	for dir in */
	do (
		check
	)
	done
}

main
echo ""
echo "DONE"
cd ~
final=`awk '{ sum += $1 } END { print sum }' data.txt` # finds the sum of all numbers in "data.txt" together
echo "$final seconds"
rm data.txt
