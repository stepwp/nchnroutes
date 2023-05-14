produce:
	curl -o delegated-apnic-latest https://ftp.apnic.net/stats/apnic/delegated-apnic-latest
	curl -o china_ip_list.txt https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt
	python3 produce.py
	mv routes4.conf /etc/routes4.conf
	birdc4 configure
	cat china_ip_list.txt|grep -v ":">>geoip_cn.txt
	mv geoip_cn.txt /www
	mv noCN.rsc /www
	python3 cnip.py
	mv CN.rsc /www
	wget -O geosite_category-ads-all.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt
	mv geosite_category-ads-all.txt /www
	wget -O geosite_geolocation-!cn.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt
	mv geosite_geolocation-!cn.txt /www
	curl https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt|grep -v github >> geosite_cn.txt
	mv geosite_cn.txt /www
	# sudo mv routes4.conf /etc/bird/routes4.conf
	# sudo mv routes6.conf /etc/bird/routes6.conf
	# sudo birdc configure
	# sudo birdc6 configure
