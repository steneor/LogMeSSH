#!/bin/sh
# Part of logMeSHH http://github.com/steneor/logMeSSS
#

IPV4_local=""    #ip v4 lan
IPV6_local=""    #ip v6 lan
IPV4=""			 #ip v4 wan	
IPV6=""          #ip v6 wan

do_get_ipv4(){   #http://debian-facile.org/doc:reseau:ip-publique
	IPV4=$(curl -s -4 http://ifconfig.co)
	echo "IPV4" $IPV4
}
do_get_ipv6(){
	IPV6=$(curl -s -6 http://ifconfig.co)
	echo "IPV6" $IPV6

}

do_get_mac(){
	# Find MAC of eth0, or if not exist wlan0
	if [ -e /sys/class/net/eth0 ]; then
    	MAC_ETH0=$(cat /sys/class/net/eth0/address)
    fi	
	if [ -e /sys/class/net/enx* ]; then
    	MAC_ENX=$(cat /sys/class/net/enx*/address)
	fi
	if [ -e /sys/class/net/wlan0* ]; then
    	MAC_WLAN0=$(cat /sys/class/net/wlan0/address)
	fi

	echo "MAC_ETH0" $MAC_ETH0
	echo "MAC_ENX" $MAC_ENX
	echo "MAC_WLAN0" $MAC_WLAN0
}

do_get_cpu_info(){
	CPU_SERIAL=$(awk '/Serial/ {print $3}' /proc/cpuinfo | sed 's/^0*//')
	CPU_HARDWARE=$(awk '/Hardware/ {print $3}' /proc/cpuinfo | sed 's/^0*//')
	CPU_REVISION=$(awk '/Revision/ {print $3}' /proc/cpuinfo | sed 's/^0*//')

	echo "CPU_SERIAL" $CPU_SERIAL
	echo "CPU_HARDWARE" $CPU_HARDWARE
	echo "CPU_REVISION" $CPU_REVISION
}

do_get_hostname(){
	HOSTNAME=$(hostname)
	echo "HOSTNAME" $HOSTNAME
}

do_get_os_release(){
	OS_RELEASE=$(cat /etc/os-release)
	echo $OS_RELEASE
}

do_get_ipv6
do_get_ipv4
do_get_mac
do_get_cpu_info
do_get_hostname
do_get_os_release


exit 0
