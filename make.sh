#!/bin/bash

#set -o noexec
#set -x

js_dir=/home/www-data/wot-monitor/js/
www_dir=/home/www-data/wot-monitor/

BASE_DIR=$(dirname $0)

function foo
{
	echo $2
	url=$1
	js_name=$2
	python $BASE_DIR/wot_ru.py $url /tmp/markers.html
	cat $BASE_DIR/head.html > $js_dir/$js_name
	cat /tmp/markers.html >> $js_dir/$js_name
	cat $BASE_DIR/footer.html >> $js_dir/$js_name
}

#Google Analytics
cp $BASE_DIR/google_analytics.js $js_dir/

foo https://atlas.ripe.net/api/internal/measurement-last/1595135/ RU1.js
foo https://atlas.ripe.net/api/internal/measurement-last/1595133/ RU2.js
foo https://atlas.ripe.net/api/internal/measurement-last/1595137/ RU3.js
foo https://atlas.ripe.net/api/internal/measurement-last/1595138/ RU4.js
foo https://atlas.ripe.net/api/internal/measurement-last/1595134/ RU5.js
foo https://atlas.ripe.net/api/internal/measurement-last/1595139/ RU6.js
foo https://atlas.ripe.net/api/internal/measurement-last/1595140/ RU7.js

for i in {1..7};
do
	sed "s/%SERVER%/RU$i/g" $BASE_DIR/ru.html > $www_dir/RU$i.html
done

echo "Done"
