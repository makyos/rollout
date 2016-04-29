#!/bin/bash

rootdir=$(dirname $0)
templatedir=${rootdir}/template
argdir=$1
index=${argdir}/index.txt

exec > >(tee ${argdir}/index.html) 2>&1

## html header
cat \
    ${templatedir}/head1.html \
    ${templatedir}/index.css \
    ${templatedir}/head2.html

## BODY/PAGES
grep -v "^\s*#\|^\s*$" ${index} | while read L; do
    if [ ! -e "${argdir}/img/${L}" ]; then
	L_OLD=${L}
    else
	echo '  <printarea size="A4yoko">'
	echo '    <hf pos="lb">'${L_OLD}'</hf>'
	echo '    <hf pos="rb">'${L}'</hf>'
	echo '    <img src="'img/${L}'"></img>'
	echo '  </printarea>'
    fi
done

## html footer
cat ${templatedir}/foot.html
