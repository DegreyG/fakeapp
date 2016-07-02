# @Author: Ethan
# @Date:   2016-05-27 15:25:31
# @Last Modified by:   Ethan
# @Last Modified time: 2016-05-27 15:58:09

fakeapp_script=./fakeapp.sh;
fakeapp_bin=./bin/fakeapp;
working_tmp=$(mktemp -t fakeapp -d);

trap 'rm -rfv $working_tmp' EXIT SIGHUP SIGINT SIGQUIT;

main () {
	echo "> Packing fakesample..."
	local fakesample_package=fakesample.tgz;
	tar czvf $working_tmp/$fakesample_package fakesample;
	cp ./fakeapp.sh $fakeapp_bin;
	printf "fakesample_package=\"" >> $fakeapp_bin;
	base64 -b 100 $working_tmp/$fakesample_package >> $fakeapp_bin;
	echo "\"" >> $fakeapp_bin;
	echo "main;" >> $fakeapp_bin;
}

main;
