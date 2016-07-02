#!/bin/bash
# @Author: Ethan
# @Date:   2016-05-27 10:34:38
# @Last Modified by:   Ethan
# @Last Modified time: 2016-07-02 19:50:28

working_tmp=$(mktemp -t fakeapp -d);
fakesample_tgz=$working_tmp/fakesample.tgz;

trap 'rm -rf $working_tmp' EXIT SIGHUP SIGINT SIGQUIT;

appname="$1";
[ -z "$appname" ] && {
	echo "Usage: fakeapp APPNAME";
	echo "ERROR: APPNAME required!";
	exit 1;
};

[ -d "$appname" ] && {
	echo "WARNING: $appname exists, do you want to continue?"
	read -p "(Y)es or (N)o: " confirm_option;
	[ "$confirm_option" != "Y" ] && {
		echo  "Cancelled."
		exit 0;
	}

	rm -rf $appname;
}

prepare_packed_files () {
	echo "> Unpacking fakesample.tgz";
	base64 -D -o $fakesample_tgz <<< "$fakesample_package";
	tar xzvf $fakesample_tgz -C $working_tmp;
	return 0;
}

replace_files () {
	echo "> Rename fakesample files"
	while read fakefile; do
		local fakename=$(basename $fakefile);
		[ -f $fakefile ] && {
			echo "- replacing $fakename";
			sed -i.bak "s/fakesample/$appname/g" $fakefile 2>/dev/null;
			rm -rf $fakefile.bak;
		};
		[[ "$(basename $fakefile)" == *fakesample* ]] && {
			echo "- rename $fakename";
			mv -v $fakefile $(dirname "$fakefile")/${fakename/fakesample/$appname};
		};
	done <<< "$(find $working_tmp/fakesample | sort -r)";
	return 0;
}

migrate_target () {
	echo "> Moving target"
	mv $working_tmp/$appname ./;
}

main () {
	prepare_packed_files;

	replace_files;

	migrate_target;

	echo "Fake app [$appname] created."
}

# generated data below
