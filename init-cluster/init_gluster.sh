#! /bin/bash
echo "[Shell: setting up glusterfs]"
set -e
if ! rpm -qa | grep yum-utils -q;
   then sudo yum install yum-utils -y
fi
yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
sudo yum-config-manager --add-repo http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/glusterfs-epel.repo
sudo yum-config-manager --enable glusterfs-epel
sudo yum install -y glusterfs glusterfs-server glusterfs-client

systemctl stop iptables || true
systemctl stop firewalld || true
systemctl enable glusterd || true
systemctl start glusterd || true
systemctl enable glusterfsd || true
systemctl start glusterfsd || true
mkdir -p /mnt/brick
mkdir /mnt/gluster
echo "[Shell: glusterfs ready]"
