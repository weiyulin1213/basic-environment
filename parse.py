import sys
file_in=open(sys.argv[ 1])
data=file_in.read()
urls=data.split('display_src": "')[ 1:]
for url in urls:
	print url.split('?ig_cache')[ 0]
