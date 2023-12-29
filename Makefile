produce:
        #curl -o delegated-apnic-latest https://ftp.apnic.net/stats/apnic/delegated-apnic-latest
        #curl -o china_ip_list.txt https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt
        curl -o geoip-only-cn-private.dat https://raw.githubusercontent.com/Loyalsoldier/geoip/release/geoip-only-cn-private.dat
        v2dat unpack geoip -o /root/nchnroutes -f cn geoip-only-cn-private.dat 
        python3 produce.py
        rm -rf /root/nchnroutes/geoip-only-cn-private_cn.txt
        # sudo mv routes4.conf /etc/bird/routes4.conf
        # sudo mv routes6.conf /etc/bird/routes6.conf
        # sudo birdc configure
        # sudo birdc6 configure

        # sudo mv routes4.conf /etc/bird/routes4.conf
        # sudo mv routes6.conf /etc/bird/routes6.conf
        # sudo birdc configure
        # sudo birdc6 configure
