#!/bin/bash

# : ${HADOOP_PREFIX:=/opt/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the *-site configuration
IPADDRESS=`ip -4 addr show scope global dev eth0 | grep inet | awk '{print \$2}' | cut -d / -f 1`
sed s/HOSTNAME/$IPADDRESS/ $HADOOP_PREFIX/etc/hadoop/core-site.xml.template > $HADOOP_PREFIX/etc/hadoop/core-site.xml
sed -i s/HOSTNAME/$IPADDRESS/ $HADOOP_PREFIX/etc/hadoop/yarn-site.xml

mkdir /opt/hadoop-config
cp -r $HADOOP_PREFIX/etc/hadoop/* /opt/hadoop-config/

service ssh start
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

if [[ $1 == "-d" ]]; then
  while true; do sleep 3000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
