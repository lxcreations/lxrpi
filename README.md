# LXRPi Project
Additional .bash files and scripts used on my Raspberry Pi's

<a href="https://www.raspberrypi.org"><img src="https://www.raspberrypi.org/wp-content/uploads/2012/03/raspberry-pi-logo.png" alt="Raspberry Pi Logo" align="left" style="margin-right: 25px" height=150></a>

> The Raspberry Pi is a credit card sized micro-computer. Their usefulness is only limited by your imagination. Official Link: [Raspberry Pi Homepage](https://raspberrypi.org)
> For more information and inspiring projects, check out the Awesome Raspberry Pi Projects below

## Awesome Raspberry Pi Projects [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/thibmaek/awesome-raspberry-pi)

## Contents

- [About](#about)
- [Install](#install)
- [Uninstall](#uninstall)
- [Bash Modifications](#bash-modifications)
- [Bash Scripts](#bash-scripts)

## About

The LXRPi Project is a set of basic files containing bash modifications and bash scripts to help you work with the Raspberry Pi (RPi) a little quicker. This project was originally created for use on the RPi's I use on my Egg Farm and Grow Op, Local Fields Ranch. With the support of other users, I have decided to make this repo a little more general and friendlier to new RPi users.

**By Default, this should only be installed on a Rasberry Pi running Raspbian**
This project is designed for the Raspberry Pi running Raspbian. It should work on any Raspbian flavor, but it is untested. With a little modification, this should be able to be installed on any Debian based system like Ubuntu or KDE Neon. With deeper modification, this could be used on any Linux flavor like OpenSuse or CentOS.

## Install

*GIT is a prerequisite for this package to be used as intended.*

To find out if you have git installed, RUN:
```which git```

To install git, RUN:
```sudo apt-get install git```

To install this repo, RUN:
```git clone https://github.com/lxcreations/lxrpi.git```

To install the LXRPi Project:
- Change directory to the project: ```cd lxrpi```
- Run: ```./install.sh```

**install.sh run through**
- back up original dotfiles
	- to ensure your original configurations are not lost in case of uninstall
- create symlinks to lxrpi dotfiles
	- allows for easy update and removal
- create ~/.lxrpi_logs directory
	- logs lxrpi
- create ~/scripts directory
	- a directory to store your custom scripts
	- this scripts directory is exported as an execicutable path via .bashrc (line: 15)
- copy email config template to ~/.lxrpi_email.conf
	- used to send email notifications via lxrpi scritps
	- this config file must be modified with your personal information
- check for basic software packages
	- marks ones missing to be installed if wanted by user
- cronjob install of updatenotice.sh
	- send email of system updates available if wanted by user
- cronjob install of lxrpi_update.sh
	- update lxrpi via git and email results if wanted by user

## Uninstall

**uninstall.sh**
- removes lxrpi dotfile symlinks and restores original dotfiles.
- removes cronjob entries related to lxrpi
- removes .lxrpi_logs directory
- removes .lxrpi_email.conf
- Does not remove installed packages or ~/scripts directory
- Does not removes installed packages installed via Apt-Get

## Bash Modifations
- **.bashrc**: most notible change in is the appearance of the shell prompt
	
	```
	user@hostname:~$
	```
	*becomes*
	```
	┌─[user@hostname]─[current_working_directory]
	└──╼ $

- **.lxrpi_bash_aliases**: shortcode entries and functions
	- To see full list, RUN: ```less ~/.lxrpi_bash_aliases```







