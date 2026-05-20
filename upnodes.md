kubectl debug node/ip-172-27-124-76.eu-west-3.compute.internal -it --image=busybox


chroot /host

mkdir -p /opt/cni/bin


wget https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-amd64-v1.3.0.tgz
tar -xzf cni-plugins-linux-amd64-v1.3.0.tgz -C /opt/cni/bin
