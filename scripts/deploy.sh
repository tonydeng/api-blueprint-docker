#!/bin/bash

if [ -d /opt/api-blueprint ]
then
    cd /opt/api-blueprint
    git checkout -f
    git clean -f
    git pull
else
    get clone $repostiory /opt/api-blueprint
    cd /opt/api-blueprint
fi

find . -name "*.md" |sed 's/.md//'|xargs -i -t aglio -i {}.md `echo $aglio` -o {}.html

rm -rf /usr/share/nginx/html/*

cp -R /usr/share/nginx/html/
