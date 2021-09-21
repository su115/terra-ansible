#!/bin/bash
# To set public ip from template_hosts to hosts

function clean(){
	sed -i 's/\[\[//g' $1
	sed -i 's/\]\]//g' $1
	sed -i 's/\"//g' $1
	sed -i 's/\,/\n/g' $1
#	sed -i 's///g' $1
}

# current dir of script
cPWD="$(echo "$PWD/$0" | rev |cut -d '/' -f 2- | rev)/"

echo  $cPWD
cd $cPWD
# K8S get ips
target_dir="../instance/" 
cd $cPWD$target_dir 
master=$(terraform output -json master )&& echo "OK\t$master" &&\
slave="[$(  terraform output -json slave)]" && echo "OK\t$slave" 
#   

# set Ansible hosts
cd $cPWD
cat template_hosts >hosts
sed -i "s/master_ip/$master/g" hosts
sed -i "s/mslaves_ip/$slave/g" hosts

clean "hosts"

