#!/bin/bash 
#TODO
# 1. 指定存檔路徑
# 2. 指定檔名prefix
# 3. 能分辨有效網址（容錯）
# 4. 依據帳號下載所有圖片
# 5. 下載flickr圖片
# 6. 自動分辨網域名

_print_help(){
	echo "./program <target url1> <url2>..."
	exit
}
#parse command line argument
_parse_commandline(){
	while getopts "p:ht:" flag
	do
		case $flag in
			"p") prefix=$OPTARG;;
			"h") _print_help;;
		esac
	done
	index=0
	arg=$@
	echo ${arg[@]}
	for ((i=$OPTIND; i<=$#; i++))
	do
		echo ${arg[$i]}
		urls[$index]=${arg[$i]}
		index=$((index+1))
	done
	echo ${urls[@]}

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
