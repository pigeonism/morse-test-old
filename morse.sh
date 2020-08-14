#!/bin/bash
# waynus 2018

mletters=(A.- B-... C-.-. D-.. E. F..-. G--. H.... I.. J.--- K-.- L.-.. M-- N-. O--- P.--. Q--.- R.-. S... T- U..- V...- W.-- X-..- Y-.-- Z--.. 1.---- 2..--- 3...-- 4....- 5..... 6-.... 7--... 8---.. 9----. 0-----)

#for a laugh , f=$(./morse.sh ermmmm); g="summary" | notify-send $f $g


# used by stringloop which sends a single letter for this functions 1st arg
function translate()
{	
	#echo $*
	# 1st arg passed in is $1...
	word="$*"

	# count for outer loop
	COUNT_WORD=0
	
		
	while [ "$COUNT_WORD" -lt "${#word}" ]
	do
		# usr letter is substring of word
		usrletter="${word:COUNT_WORD:1}"

		# count for inner loop
		COUNT_L=0

		while [ "$COUNT_L" -lt "${#mletters[@]}" ]
		do
			# morse full is entire array Element at lcount, a string
			morse_full="${mletters[$COUNT_L]}"
			# morse is a substring of morse full, the alphabet character part		
			morse_letter="${morse_full:0:1}"

			# check if both letters are the same
			if [ "$usrletter" = "$morse_letter" ]; then
				#echo "match, morse: ${morse_full:1}"
				echo -n "\\${morse_full:1}"
				#change count to make the while condition false
				COUNT_L=$(("${#mletters[@]}"+100))

			elif [ "$usrletter" = " " ]; then
				#echo "space found"
				echo -n '\ '
				#change count to make the while condition false
				COUNT_L=$(("${#mletters[@]}"+100))
			else
				#echo "no match"	
				COUNT_L=$(("$COUNT_L"+1))
			fi	
			
		done

	COUNT_WORD=$(("$COUNT_WORD"+1))
	done
} 

#translate
# if num of args is 0,
if [ "$#" -eq 0 ]; then
	echo "Defaulting to interactive mode..."
	echo
	# get chars from stdin
	read -p "Enter some text: " text
	if [[ "${#text}" -gt 0  ]] #if len text is greater than 0
	then
		
		# to upper ,, is lower
		text="${text^^}"
		translate "$text"
		echo

	else
		echo "no text entered" # or read again
	fi

	# top else, pass args to translate
	else
		#echo $*
		text="$*"
		text="${text^^}"
		translate "$text"
		echo
fi

exit
