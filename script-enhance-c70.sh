#https://www.dedoimedo.com/computers/fedora-ultimate-customization-guide.html
#https://opensource.com/article/17/8/customize-linux
#https://itsfoss.com/best-gnome-extensions/

#Install script for enhance fedora
USUARIO=ricardo.carrillo
CORREO="dominus.ceo@gmail.com"
yum update 
yum install -y epel-release && yum update -y
yum install -y terminator git 

# Git configuration
git config --global user.name "$USUARIO"
git config --global user.email $CORREO
git config --global core.editor vim

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
yum install -y automake gcc gcc-c++ kernel-devel cmake python-devel
yum install -y ncurses

# Bittorrent download
yum install -y qbittorrent transmission

## Utilities
yum install -y lshw lsscsi
yum install -y hddtemp udisks2
yum install -y mediawriter etcher-electron
yum install -y terminator clusterssh
yum install -y axel
yum install -y rsyslog screen htop
systemctl enable  rsyslog
systemctl restart rsyslog
# Network monitor
yum install -y iptraf nmap
#Performance and monitoring
yum install -y sysstat psacct glances
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
systemctl start libvirtd
systemctl enable libvirtd

# Red Hat and Ubuntu Fonts
cd /tmp && git clone https://github.com/RedHatBrand/Overpass.git
cd Overpass && cp -rvap desktop-fonts/overpass* /usr/share/fonts/
cd /tmp && git clone https://github.com/dominusceo/linux-fonts.git
cd linux-fonts && cd Ubuntu cp -vap Ubuntu-*ttf /usr/share/fonts/
fc-cache -v -f /usr/share/fonts/
