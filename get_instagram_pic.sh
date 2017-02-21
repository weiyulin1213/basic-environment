#!/bin/bash 
#TODO
# 1. 指定存檔路徑done
# 2. 指定檔名prefix done
# 3. 能分辨有效網址（容錯）
# 4. 依據帳號下載所有圖片partially done
# 5. 下載flickr圖片
# 6. 自動分辨網域名
# 7. instagram tags picture download.

username='!'
tags="@"
tmp_file='.tmp_file01'
python='python2.7'
parser='parse.py'
prefix='default'
_print_help(){
	echo "./program <target url1> <url2>..."
	echo "./program -u <username>"
	echo "./program -p <file name prefix>"
	echo "./program -t <instagram explore tags>"
	exit
}
#parse command line argument
valid_count=0
_parse_commandline(){
	while getopts "p:hu:t:" flag
	do
		case $flag in
			"p") prefix=$OPTARG;;
			"h") _print_help;;
			"u") username=$OPTARG;;
			"t") tags=$OPTARG;;
		esac
	done
	index=0
	arg=$@
	# support multiple input urls
	for w in $arg
	do
		if [ `expr "$w" : ".*\(http.*instagram\)"` ]; then
			urls[$index]=$w
			index=$((index+1))
			valid_count=$((valid_count+1))
		fi
	done
}
# this function will parse website and store image into a file
_parse_content(){
	i=0
	for url in $@
	do
		http=`curl -s $url`
		if [ $? -eq 0 ]; then
			echo "get webpage content success..."
			img=`expr "$http" : '.*\(https.*n\.jpg\)'`
			curl $img > ${prefix}${i}.jpg
		fi
		i=$((i+1))
	done
}
# this function will download image by username specified
_download_by_username(){
	curl -s https://www.instagram.com/${username}/ > $tmp_file
	urls=(`$python $parser $tmp_file`)
	i=0
	mkdir ${username}
	for url in ${urls[@]}
	do
		curl $url > ${username}/${prefix}${i}.jpg
		i=$((i+1))
	done
	rm $tmp_file
}
# this is main function
_main(){
	_parse_commandline $@
	if [ $username != '!' ]; then
		echo "target username: $username"
		_download_by_username
	elif [ $# -ne 0 ]; then
		echo "$valid_count valid urls imported."
		echo "parsing..."
		_parse_content ${urls[@]}
	else
		echo "usage: ./program instragram_picture_url..."
	fi
}

_main $@
