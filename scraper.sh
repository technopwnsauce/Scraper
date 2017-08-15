#!/bin/bash
while true
do
	#Download page of interest
	wget --post-data="over18=yes" https://www.reddit.com/over18?dest=https%3A%2F%2Fwww.reddit.com%2Fr%2Fpics%2Fnew -O pulled.html
	wget --post-data="over18=yes" https://www.reddit.com/over18?dest=https%3A%2F%2Fwww.reddit.com%2Fr%2Fneckbeardnests%2Fnew -O ->> pulled.html	
	wget --post-data="over18=yes" https://www.reddit.com/over18?dest=https%3A%2F%2Fwww.reddit.com%2Fr%2Fimgoingtohellforthis%2Fnew -O ->> pulled.html
	wget --post-data="over18=yes" https://www.reddit.com/over18?dest=https%3A%2F%2Fwww.reddit.com%2Fr%2Fanimegifs%2Fnew -O ->> pulled.html
	wget --post-data="over18=yes" https://www.reddit.com/over18?dest=https%3A%2F%2Fwww.reddit.com%2Fr%2Fanimefigures%2Fnew -O ->> pulled.html
	
	#Parse imgur links into a file for potential retrieval
	grep -o -P 'https?://i\.(redd|imgur)\.(com|it)/[^\.]*\....' pulled.html > pulled.txt

	#Sort the links(for comparison) and remove duplciates
	sort pulled.txt -o pulled.txt
	sort -u pulled.txt -o pulled.txt

	#Find links which are new, i.e. in pulled but not master
	comm -13 master.txt pulled.txt > to_download.txt

	#Download the links
	wget -i to_download.txt -P images

	#Add downloaded links to the master list
	cat to_download.txt >> master.txt

	#Sort the master list (to allow for later comparisons)
	sort master.txt -o master.txt

	#Pause
	sleep 60
done
