#!/bin/bash
for j in man odt html
do
	rm -rf $j
	mkdir -p $j
	for i in $(ls rst/*.rst | sed "s/.rst$//g" | sed "s/rst\///g" | sort)
	do
		rst2$j rst/$i.rst > $j/$i.$j
	done
done
sed -i 's|</head|<link rel="stylesheet" href="main.css">\n</head|g' html/*.html
cat main.css > html/main.css
echo "<head><title>Sayfalar</title></head><body>" > index.html
for i in $(ls html | sed "s/.html//g" | sort)
do
	echo -e "=> <a href=\"html/$i.html\">$i</a><br>" >> index.html
done
echo "</body>" >> index.html
