#!/bin/bash
#when is this
STAMP=$(date +%Y%m%d_%H%M%S)
#where are we
SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

#include the baspi config file
source $SOURCEDIR/config/lxrpi.conf

#create initial ID variable for OS
ID="unknown"

#include OS details
source /etc/os-release


echo "LXRPi install script =============================================

LXRPi should only be installed on a Raspberry Pi running Raspian
Please review the README.md and text files in the notes directory
for more details before installing.
The lxrpi directory in your $HOME directory must remain, DO NOT DELETE!"
echo

while true; do
    read -p "Do you wish to install LXRPi? [y/n]: " doinstall
    case $doinstall in
        [Yy]* ) echo "continue"; break;;
        [Nn]* ) echo "exiting"; exit ${0};;
        * ) echo "Please answer y for yes or n for no.";;
    esac
done

#display the current OS
echo "Current OS Version: "$PRETTY_NAME
echo

#Install ONLY if we are running Raspian
if [ "$ID" != "raspbian" ]; then
  echo "ERROR: This is only tested the Raspberry Pi running Raspian.
  Install is exiting."
  # as a bonus, make our script exit with the right error code.
  exit ${1}
fi

#get the current hostname
HOSTNAME=$(hostname)

for file in $(find $SOURCEDIR/dotfiles/. -maxdepth 1 -name ".*" -type f  -printf "%f\n" ); do
   if [ -e $HOME/$file ]; then
     if [ ! -L $HOME/$file ]; then
       echo "Backup original dotfile: "$file
       mv -f $HOME/$file{,.dtbak}
     fi
   fi
   if [ ! -e $HOME/$file ]; then
     echo "Install custom dotfiles: "$file
     ln -s $SOURCEDIR/dotfiles/$file $HOME/$file
   fi
done
echo "Dotfiles installed"

echo

#create the scripts directory
if [ ! -d $HOME/.lxrpi_logs ]; then
    mkdir $HOME/.lxrpi_logs
    echo "$HOME/.lxrpi_logs directory Created"
fi

#create the scripts directory
if [ ! -d $HOME/scripts ]; then
    mkdir $HOME/scripts
    echo "$HOME/scripts directory Created"
fi

#email config for lxrpi 
if [ ! -e $HOME/.lxrpi_email.conf ]; then
    cp $SOURCEDIR/config/lxrpi_email.conf $HOME/.lxrpi_email.conf
    echo "$HOME/.lxrpi_email.conf file created
    You must modify the sendemail configuration file
    nano $HOME/.lxrpi_email.conf"
fi
echo 

#create variable for needed installable apps
APTINSTALLS=""

#if git is not installed, mark it for install
if [ ! -e /usr/bin/git ]; then
    APTINSTALLS="$APTINSTALLS git"
fi

#if pip is not installed, mark it for install
if [ ! -e /usr/bin/pip ]; then
    APTINSTALLS="$APTINSTALLS python-pip"
fi

#if pip3 is not installed, mark it for install
if [ ! -e /usr/bin/pip3 ]; then
    APTINSTALLS="$APTINSTALLS python3-pip"
fi

#if sendemail is not installed, mark it for install
if [ ! -e /usr/bin/sendemail ]; then
    APTINSTALLS="$APTINSTALLS sendemail"
fi

#if sysstat is not installed, mark it for install
if [ ! -e /usr/bin/iostat ]; then
    APTINSTALLS="$APTINSTALLS sysstat"
fi

#if snmp is not installed, mark it for install
if [ ! -e /usr/sbin/snmpd ]; then
    APTINSTALLS="$APTINSTALLS snmpd snmp"
fi

#if samba is not installed, mark it for install
if [ ! -e /usr/sbin/samba ]; then
    APTINSTALLS="$APTINSTALLS samba samba-common-bin"
fi

if [ "$APTINSTALLS" != "" ]; then
  echo "These packages need to be installed."
  echo $APTINSTALLS
  echo
  
  while true; do
      read -p "Would you like to install these via apt-get? [y/n]: " doinstall
      case $doinstall in
          [Yy]* )
              echo "installing";
              echo
              
              AGINSLOG=$HOME/.lxrpi_logs/aptgetoninstall_$(date +%Y%m%d_%H%M%S).log
              sudo apt-get update; sudo apt-get install -y $APTINSTALLS > $AGINSLOG 2>&1
              echo "
              ================================================================================
              Review $AGINSLOG for install details
              
              Modify /etc/snmp/snmpd.conf for best results of snmp monitoring
              Modify /etc/samba/smb.conf for best results of file sharing
              =================================================================================
              "
              echo
              break;;
          [Nn]* ) echo "skipping"; break;;
          * ) echo "Please answer y for yes or n for no.";;
      esac
  done
fi


#install the update notice script in crontab
#SEE notes/updatenotice.txt for details

echo "The Update Notice checks for updates via apt and emails you the results.
It is installed as a cronjob to run once a week, Sunday at 1AM.
This only notifies you of updates, it does not install them.
The sendemail package is required and will be installed if needed if you choose yes."
echo
while true; do
    read -p "Would you like to install the Update Notice cron job? [y/n]: " doinstall
    case $doinstall in
        [Yy]* )
            echo "Installing Cronjob";
            echo
            if [ -e /usr/bin/sendemail ]; then
              ( crontab -l | grep -v -F "$UPDATESCRIPT" ; echo "$UPDATECRON" ) | crontab -
            else
              echo "Sendemail package is missing, installing now."
              sudo apt-get update; sudo apt-get install -y sendemail > $AGINSLOG 2>&1
              ( crontab -l | grep -v -F "$UPDATESCRIPT" ; echo "$UPDATECRON" ) | crontab -
            fi
            break;;
        [Nn]* ) echo "skipping"; break;;
        * ) echo "Please answer y for yes or n for no.";;
    esac
done

echo "LXRPi can be updated via cron as well. This will run as a cronjob on
Sunday at 1:30 AM. This requires git to be installed. If git is missing, it will
be automatically installed if you choose yes."
echo
while true; do
    read -p "Would you like to auto-update LXRPi? [y/n]: " doinstall
    case $doinstall in
        [Yy]* )
            echo "Installing Cronjob";
            echo
            if [ -e /usr/bin/git ]; then
              ( crontab -l | grep -v -F "$LXRPIUPDATESCRIPT" ; echo "$LXRPIUPDATECRON" ) | crontab -
            else
              echo "Git package is missing, installing now."
              sudo apt-get update; sudo apt-get install -y git > $AGINSLOG 2>&1
              ( crontab -l | grep -v -F "$LXRPIUPDATESCRIPT" ; echo "$LXRPIUPDATECRON" ) | crontab -
            fi
            break;;
        [Nn]* ) echo "Read notes/lxrpi_update.txt for manual updates"
            break;;
        * ) echo "Please answer y for yes or n for no.";;
    esac
done

#warn about changing the hostname from original
if [ "$HOSTNAME" = "raspberrypi" ]; then
  echo "Hostname is set as default, you may want to change it to a specific name."
  echo 
fi

#inform about updating the currently used bash shell
echo "To refresh the bash console, run command
source ~/.bashrc

To remove LXRPi, run the uninstaller in this directory.
run command: ./uninstall.sh

To view no aliases, run command: less $HOME/.lxrpi_bash_aliases"
