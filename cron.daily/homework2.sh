#!/bin/bash
echo 'script started'
echo "user: $(whoami)"
cd ~
echo "pwd: $(pwd)"

# create file
export filename=newfile$(date -I).txt
echo "filename: $filename"
base64 /dev/urandom | head -c 1000000 > $filename

# move to other server
rsync -avz $filename root@158.160.113.199:~

echo 'txt files here:'
ssh root@158.160.113.199 find '*.txt' -maxdepth 0 -print
echo 'older then 1 day files:'
ssh root@158.160.113.199 find '*.txt' -maxdepth 0 -mtime +1 -print
#delete files
ssh root@158.160.113.199 find '*.txt' -maxdepth 0 -mtime +1 -delete

echo 'script ended'
