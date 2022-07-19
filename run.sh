#!/bin/zsh
a=("${(f)$(< ports_list)}")
tr '\n' ',' < ports_list > output.txt
sudo nmap -sV -v -Pn -p $(cat output.txt) -iL ./ip_list -oA nmap/scan-from-$(curl ipconfig.io)-v3


sudo nmap --script vuln -sV -v -Pn -p $(cat output.txt) -iL ./ip_list -oA nmap/scan-from-$(curl ipconfig.io)
python3 ./nmap-converter.py ./nmap/scan-from-$(curl ipconfig.io).xml -o ./result/scan-result-$(curl ipconfig.io).xls

a=("${(f)$(< ports_list)}")
for i in $a
do
sudo nmap -sV -v -Pn -p $i -iL ./ip_list -oA nmap/scan-from-$(curl ipconfig.io)-on-port-$i
done
