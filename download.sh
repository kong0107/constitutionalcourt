#!/bin/bash
# Program:
#	�q�q�k�|�����U�����r����
start=1
end=724
for(( expno=$start; expno<=$end; expno=expno+1 ))
do
	cmd="wget http://www.judicial.gov.tw/constitutionalcourt/p03_01.asp?expno=$expno --output-document=downloads/p03_01/$expno.html --tries=1"
	$cmd
	sleep 1
done