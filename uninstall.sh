#!/bin/bash

for file in $(find $SOURCEDIR/dotfiles/. -maxdepth 1 -name ".*" -type f  -printf "%f\n" ); do
    if [ -h $HOME/$file ]; then
        echo "Removing: "$file
        rm -f $HOME/$file
    fi
    if [ -e $HOME/${file}.dtbak ]; then
        echo "Restoring: "${file}.dtbak
        mv -f $HOME/$file{.dtbak,}
    fi
done

#remove cron entries
( crontab -l | grep -v -F "$UPDATESCRIPTBASE" ) | crontab -
( crontab -l | grep -v -F "$LXRPIUPDATESCRIPTBASE" ) | crontab -

#remove basepi config directory
rm -rf $HOME/.lxrpi_logs $HOME/.lxrpi_email.conf

echo "Uninstalled"
echo "To refresh the bash console, run command"
echo "source ~/.bashrc"