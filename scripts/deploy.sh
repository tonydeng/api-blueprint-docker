#!/bin/sh
# update api blueprint documet
if [ -d /opt/api-blueprint ]
then
    cd /opt/api-blueprint || exit

    if [[ -n "$(repository)" ]]; then
        echo "git pull $repository"
        git checkout -f
        git clean -f
        git pull
    fi

else
        echo "git clone $repository"
        git clone $repository /opt/api-blueprint
        cd /opt/api-blueprint || return
fi

# convert tab and space
sed -i 's/\t/\ \ /g' *.apib
chmod 644 *.apib

# build api document
find . -name "*.apib" | sed 's/.apib//' |xargs -i -t aglio -i {}.apib `echo "$(aglio)"` -o {}.html

# cp source api docs 2 nginx serve directroy
dst=/usr/share/nginx/html
rm -rf "${dst:?}/"*
for i in `find . -name "*.html"`; do
        mkdir -p $dst/`dirname $i`;
        cp -f $i $dst/$i;
done

# restart drakov
pkill -9 drakov
sleep 1
drakov -f "/opt/api-blueprint/*.apib" --public &
