produce:
	rm -rf geosite_category-ads-all.txt
	rm -rf geosite_geolocation-!cn.txt
	rm -rf geosite_cn.txt
	curl https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt|grep -v github >> geosite_cn.txt
	wget -O geosite_geolocation-!cn.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt
	wget -O geosite_category-ads-all.txt https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt
	rm -rf ipv4-address-space.csv
	rm -rf delegated-apnic-latest
	rm -rf china_ip_list.txt
	curl -o ipv4-address-space.csv https://www.iana.org/assignments/ipv4-address-space/ipv4-address-space.csv
	curl -o delegated-apnic-latest https://ftp.apnic.net/stats/apnic/delegated-apnic-latest
	curl -o china_ip_list.txt https://raw.githubusercontent.com/Loyalsoldier/geoip/release/text/cn.txt
	rm -rf routes4.conf
	rm -rf routes6.conf
	rm -rf noCN.rsc
	python3 produce.py
	# mv routes4.conf /etc/routes4.conf
	# birdc4 configure
	rm -rf geoip_cn.txt
	cat china_ip_list.txt|grep -v ":">>geoip_cn.txt
	# mv geoip_cn.txt /www
	# mv noCN.rsc /www
	rm -rf CN.rsc
	python3 cnip.py
	# mv CN.rsc /www
	# mv geosite_category-ads-all.txt /www
	# mv geosite_geolocation-!cn.txt /www
	# mv geosite_cn.txt /www
	# sudo mv routes4.conf /etc/bird/routes4.conf
	# sudo mv routes6.conf /etc/bird/routes6.conf
	# sudo birdc configure
	# sudo birdc6 configure
