#!/bin/sh 

#parse command line argument
_parse_commandline(){
	while getopts "p:" flag
	do
		case $flag in
			"p") prefix=$OPTARG;;
		esac
	done
	echo $prefix
}
# this function will parse website and store image into a file
_parse_content(){
	i=0
	for url in $@
	do
		http=`curl -s $url`
		img=`expr "$http" : '.*\(https.*n\.jpg\)'`
		curl $img > pic${i}.jpg
		i=$((i+1))
	done
}

# this is main function
_main(){
	_parse_commandline $@
	if [ $# -ne 0 ]; then
		echo $# urls imported
		echo "parsing..."
		_parse_content $@
	else
		echo "usage: ./program instragram_picture_url..."
	fi
}

_main $@
