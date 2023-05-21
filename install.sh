#! /bin/bash

echo "Checking if git is installed"
if ! command -v git &> /dev/null
then
    echo "Git could not be found. Installing git"
    apt-get git -y
fi

echo "Cloning repositiories."

echo "Cloning aes67-linux-daemon"
git clone https://github.com/gubbsjuk/aes67-linux-daemon.git

echo "Installing aes67-linux-daemon dependencies."
apt update
apt install -y build-essential, clang, cmake, libboost-all-dev, libasound2-dev, linux-headers-$(uname -r), libavahi-client-dev #use ubuntu-packages.sh instead?

#Compile and install kernel module
cd aes67-linux-daemon/3rdparty/ravenna-alsa-lkm/driver
make
cp MergingRavennaALSA.ko /lib/modules/$(uname -r)/kernel/drivers
depmod

echo "Apply kernel parameters."
sysctl -w kernel.sched_rt_runtime_us=1000000 #set total bandwidth available to all real-time tasks to 100% of CPU
sysctl -w kernel.perf_cpu_time_max_percent=0 #Disable CPU scaling

ps ax | grep pulseaudio #TODO: implement IF statement. to break execution.


#Compile and deploy daemon and webUI.
cd ../../
./build.sh

#deploy with systemd
cd systemd
./install.sh

#edit etc/daemon.conf
echo "Configure instance."
echo "Specify a unique name:"
read name

echo "Specify wanted sample-rate. (44.1/48)
read sample-rate

echo "Specify wanted port for Aes67 webUI or leave blank for default (9000)"
read port

if [[ -z $port ]]; then
    port=9000
fi
echo "Port $port specified" #TODO: Check if already used?

echo "Specify wanted interface for AES67"
interfaces=$(ip link | awk -F: '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}')
echo $interfaces
read interface

if [[ "$interfaces" != *"$interface"* ]]; then
        echo "Invalid interface $interface"
        exit
fi

echo "You selected $interface"

echo Specify wanted format (S16/S24) #TA bort denne?


#start daemon
systemctl start aes67-daemon

# TESTS????



echo "Cloning librespot"
git clone xxxx

echo "Installing librespot dependencies."
#install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt
rustup component add clippy

apt install pkg-config
cd ..
cd librespot

cargo build --no-default-features --features "alsa-backend"

echo "Specify wanted port for Aes67 webUI or leave blank for default (9000)"

echo Specify wanted format (S16/S24) #TA bort denne?

#Apply configuration below here
