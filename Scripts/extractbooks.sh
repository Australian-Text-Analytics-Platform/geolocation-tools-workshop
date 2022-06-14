#!/bin/bash
# Bash script to separate the "For the Term of His Natural Life" into separate files for each Book, the Contents, Dedication and Appendix

# Note that the input filename was renamed as e00016_simplifiedascii.txt
TITLE=FtToHNL;rm ${TITLE}_[A-Z]*txt;echo 'BOOK 0'>tmp.txt;cat e00016_simplifiedascii.txt>> tmp.txt;awk -v ATITLE="$TITLE" '/^(BOOK |APPENDIX\.|PROLOGUE\.|CONTENTS)/{x=ATITLE"_PART_"++i;}{print >>x;}' tmp.txt;mv ${TITLE}_PART_1 ${TITLE}_DEDICATION.txt; cat ${TITLE}_PART_[2-6]* > ${TITLE}_CONTENTS.txt; mv ${TITLE}_PART_7 ${TITLE}_PROLOGUE.txt; mv ${TITLE}_PART_8 ${TITLE}_BOOK_1.txt; mv ${TITLE}_PART_9 ${TITLE}_BOOK_2.txt; mv ${TITLE}_PART_10 ${TITLE}_BOOK_3.txt;mv ${TITLE}_PART_11 ${TITLE}_BOOK_4.txt; cat ${TITLE}_PART_1[23456] > ${TITLE}_APPENDIX.txt|rm ${TITLE}_PART_* tmp.txt
