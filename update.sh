#!/bin/bash
for j in man odt html
do
	rm -rf $j
	mkdir -p $j
	for i in $(ls rst/*.rst | sed "s/.rst$//g" | sed "s/rst\///g")
	do
		rst2$j rst/$i.rst > $j/$i.$j
	done
done
