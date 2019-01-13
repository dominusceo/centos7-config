# Autor: Carrillo Sanchez Ricardo David
#Install script for enhance CentOS7
#Goal: Make an Centos 7 environment for lab study
USUARIO=ricardo.carrillo
CORREO="dominus.ceo@gmail.com"
rpm -Uhv http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum update
yum install -y epel-release && yum update -y
# Enable SSH Service
systemctl enable sshd
systemctl start sshd
# Media Writer images called etcher-electron
wget https://bintray.com/resin-io/redhat/rpm -O /etc/yum.repos.d/bintray-resin-io-redhat.repo

### Install chrome
yum install -y chromium

### VirtualBox Red Hat/Centos 7 users
cd /etc/yum.repos.d/
usermod -a -G vboxusers $USUARIO

# Customization, graphics & Themes
yum install -y gnome-tweak-tool
yum install -y numix\*

# Reading ntfs partitions
yum install -y ntfs-3g ntfsprogs

# Install Java plugins
yum install -y icedtea-web java-11-openjdk

# Compilers for c-programming
yum groupinstall -y "Development Tools"
yum install -y automake gcc gcc-c++ kernel-devel python-devel ncurses

# Bittorrent download
yum install -y qbittorrent transmission

## Utilities
yum install -y lshw lsscsi hddtemp udisks2
yum install -y mediawriter etcher-electron
yum install -y terminator clusterssh
yum install -y axel
yum install -y rsyslog screen htop
#Performance and monitoring
yum install -y sysstat psacct glances
systemctl enable  rsyslog
systemctl restart rsyslog
# Network monitor
yum install -y iptraf nmap
# Monitoreo de hardware (temperature fans,cpus and video cards)
# para powertop para calibrar la bateria
yum install -y lm_sensors powertop
systemctl start powertop.service
systemctl enable powertop.service

#Tuned is a dynamic adaptive system-tuning daemon that tunes system settings dynamically depending on usage
#https://opensource.com/article/17/8/customize-linux
#dnf install -y tuned-gtk.noarch  tuned.noarch  tuned-utils.noarch
#systemctl enable tuned
#systemctl start tuned

# Password manager
yum install -y keepass
#Compression
yum install -y unzip p7zip
# Powerline Install
yum install -y vim-enhanced vim-common

# Virtualization
yum groupinstall -y "Virtualization Host"
yum groupinstall -y "virtualization-platform"
yum install -y virt-manager qemu qemu-kvm qemu-img qemu-kvm-tools virt-install virt-viewer
systemctl start libvirtd
systemctl enable libvirtd

# Record de screen for classlab
yum install -y ffmpeg simplescreenrecorder gstreamer1-libav libdvdcss gstreamer{,1}-plugins-ugly gstreamer-plugins-bad-nonfree gstreamer1-plugins-bad-freeworld libde265 x265


# Specific terminal
yum install -y terminator git
# Git configuration
git config --global user.name "$USUARIO"
git config --global user.email $CORREO
git config --global core.editor vim

# Red Hat and Ubuntu Fonts
cd /tmp && git clone https://github.com/RedHatBrand/Overpass.git
cd Overpass && cp -rvap desktop-fonts/overpass* /usr/share/fonts/
cd /tmp && git clone https://github.com/dominusceo/linux-fonts.git
cd linux-fonts && cd Ubuntu cp -vap Ubuntu-*ttf /usr/share/fonts/
fc-cache -v -f /usr/share/fonts/

# Install PowerLine for CentOS7
yum install -y python2-pip
pip install git+git://github.com/Lokaltog/powerline
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -O /usr/share/fonts/
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -O /etc/fonts/conf.d/

cat << _EOF_ >> /etc/profile
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
_EOF_
# Menu pesonalization
yum install -y alacarte

# V2V tools for convert guest vmware to kvm guest
yum install -y virt-v2v
# Installing windows drivers repository
# https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html
wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo   -O /etc/yum.repos.d/virtio-win.repo
yum install -y virtio-win

# descompressors 
yum install unrar p7zip
