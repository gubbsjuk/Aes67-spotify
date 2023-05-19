#! /bin/bash

echo "Checking if git is installed"
if ! command -v git &> /dev/null
then
    echo "Git could not be found. Installing git"
    apt-get git -y
fi

echo "Cloning repositiories."

echo "Cloning aes67-linux-daemon"
git clone xxx

echo "Installing aes67-linux-daemon dependencies."
apt-get xxxx,xxxx,xxx,xxxx -y

echo "Cloning librespot"
git clone xxxx

echo "Installing librespot dependencies."
apt-get xxxx,xxxx,xxxx -y

echo "Apply kernel parameters."
xxx
xxx
xxx

echo "Configure instance."
echo "Specify a unique name:"
read name

echo "Specify wanted sample-rate. (44.1/48)
read sample-rate

echo "Specify wanted port for Aes67 webUI or leave blank for default (9000)"

echo Specify wanted format (S16/S24) #TA bort denne?

#Apply configuration below here
