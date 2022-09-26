#!/bin/bash
# Bash script to separate the "For the Term of His Natural Life" into separate files for each Book, the Contents, Dedication and Appendix.
# The Chapters are then extracted from each Book.

# Note that this script is assumed to be run from the same directory as the input file.
TITLE=FtToHNL;INPUTTEXT=${TITLE}_simplifiedascii.txt;
echo "Dividing "${INPUTTEXT}" into sections" 
rm ${TITLE}_[A-Z]*txt;
echo 'BOOK 0'>tmp.txt;cat ${INPUTTEXT} >> tmp.txt;
awk -v ATITLE="$TITLE" '/^(BOOK |APPENDIX\.|PROLOGUE\.|CONTENTS)/{x=ATITLE"_PART_"++i;}{print >>x;}' tmp.txt;
mv ${TITLE}_PART_1 ${TITLE}_DEDICATION.txt;
cat ${TITLE}_PART_[2-6]* > ${TITLE}_CONTENTS.txt;
mv ${TITLE}_PART_7 ${TITLE}_PROLOGUE.txt;
mv ${TITLE}_PART_8 ${TITLE}_BOOK_1.txt;
mv ${TITLE}_PART_9 ${TITLE}_BOOK_2.txt;
mv ${TITLE}_PART_10 ${TITLE}_BOOK_3.txt;
mv ${TITLE}_PART_11 ${TITLE}_BOOK_4.txt;
cat ${TITLE}_PART_1[23456] > ${TITLE}_APPENDIX.txt|rm ${TITLE}_PART_* tmp.txt

# Now, break each book into chapters
for book in `ls ${TITLE}_BOOK_*txt`
do
    BOOKTITLE=`echo ${book} | sed 's/.txt//'`
    echo "Finding chapters for "${BOOKTITLE}
    rm -f ${BOOKTITLE}_CHAPTER*
    declare -i linenum=`grep -n -h -m 1 "^CHAPTER " ${book}|sed 's/:.*$//'`
    #echo LINENUM=${linenum}
    declare -i filesize=`wc -l ${book}|sed 's/^ *//'|sed 's/ .*$//'`
    #echo "LINES IN FILE="${filesize}
    declare -i numlinestoparse=filesize-linenum+1
    #echo "LINES TO PARSE="${numlinestoparse}
    tail -n ${numlinestoparse} ${book}|awk -v ABOOKTITLE="${BOOKTITLE}" '/^(CHAPTER )/{y=ABOOKTITLE"_CHAPTER_"++j".txt";}{print > y;}'
done    
