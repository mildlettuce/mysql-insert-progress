#!/bin/bash

if [ -z "$1" ]
then
	echo "No argument supplied. Syntax: `basename $0` [FILE]"
	exit
fi

FILE="$1"
if [ ! -f $FILE ]; then
    echo "File not found! (${FILE})"
    exit
fi

# MySql Executable. Add user/password here
MYSQL="/usr/bin/mysql"

# The SQL we're looking for. If doing a batch UPDATE, change this.
SQL="INSERT INTO.{70}"

# Initialize parameters
NUM_LINES=`wc -l < $FILE`
PC=0.0
PCI=0
LAST_LINE=2

#Loop up to 99%
while [ $PCI -lt 99 ]
do
	# Get the currently executing SQL Statement
	LINE_PART=`${MYSQL} -A -e "show full processlist" | egrep -oh "$SQL"`
	# Find the line number
	LINE_NUM=`grep -n -m 1 "$LINE_PART" $FILE | cut -f1 -d:`
	# To percentage
	PC=`echo "scale=2; ${LINE_NUM}*100/${NUM_LINES}"  | bc`
	# To integer (for while loop)
	PCI=`printf %.0f "$PC"`

	# If we couldn't find the line number
	if [ $LAST_LINE -gt $LINE_NUM ];
	then
		# Allow a maximum of 10 attempts
		NOSQL=$((NOSQL+1))
		echo "NO INSERT for ${NOSQL}/10 attempts"
		sleep 3
		if [ $NOSQL -gt 10 ];
		then
			break
		fi
	else
		# Progress has been made, keep going
		NOSQL=0
		LAST_LINE=$LINE_NUM
		echo "Line $LINE_NUM out of $NUM_LINES (${PC}%) $PC_OLD"
	fi

sleep 1
done                
