#!/bin/bash
for j in man odt
do
	rm -rf $j
	mkdir -p $j
	for i in $(ls rst/*.rst | sed "s/.rst$//g" | sed "s/rst\///g" | sort)
	do
		rst2$j rst/$i.rst > $j/$i.$j
	done
done
rm -rf html
mkdir -p html
for i in $(ls rst/*.rst | sed "s/.rst$//g" | sed "s/rst\///g" | sort)
do
	rst2html --link-stylesheet rst/$i.rst > html/$i.html
done
sed -i 's|href=.*.css|href=\"main.css|g' html/*.html

cat main.css > html/main.css
echo "<head><title>Sayfalar</title>" > index.html
echo '<link rel="stylesheet" href="main.css" />' >> index.html
echo "</head><body>" >> index.html
for i in $(ls html | grep ".html$" | sed "s/.html//g" | sort)
do
	echo -e "=> <a href=\"html/$i.html\">$i</a><br>" >> index.html
done
echo "</body>" >> index.html
