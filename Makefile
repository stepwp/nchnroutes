produce:
	git pull
	curl -o delegated-apnic-latest https://ftp.apnic.net/stats/apnic/delegated-apnic-latest
	curl -o china_ip_list.txt https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt
	python3 produce.py
	mv routes4.conf /etc/routes4.conf
	birdc4 configure
	mv noCN.rsc /www
	# sudo mv routes4.conf /etc/bird/routes4.conf
	# sudo mv routes6.conf /etc/bird/routes6.conf
	# sudo birdc configure
	# sudo birdc6 configure
