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
- [Bash Modifations](#bashmods)
- [Bash Scripts](#bashscripts)

## About

The LXRPi Project is a set of basic files containing bash modifications and bash scripts to help you work with the Raspberry Pi (RPi) a little quicker. This project was originally created for use on the RPi's I use on my Egg Farm and Grow Op, Local Fields Ranch. With the support of other users, I have decided to make this repo a little more general and friendlier to new RPi users.

**By Default, this should only be installed on a Rasberry Pi running Raspbian**
This project is designed for the Raspberry Pi running Raspbian. It should work on any Raspbian flavor, but it is untested. With a little modification, this should be able to be installed on any Debian based system like Ubuntu or KDE Neon. With deeper modification, this could be used on any Linux flavor like OpenSuse or CentOS.

## Install

*GIT is a prerequisite for this package to be use as intended.*

To find out if you have git installed, RUN:
```which git```

To install git, RUN:
```sudo apt-get install git```

To install this repo, RUN:
```git clone https://github.com/lxcreations/lxrpi.git```


**install.sh** - install all dotfiles and software used on the Raspberry Pi in the users home directory, usually /home/pi
- Install also creates a scripts directory (~/scripts) for you to place custom bash, python, and other scripts. This directory is also placed in the .bashrc as an executable path
- Installs packages if needed
	- git <<  used to get GIT packages/repos
	- sendemail << send email via bash scripts
	- python-pip << install python packages
	- python-pip3 << install python3 packages
	- sysstat << get system status information
	- snmp << monitor with snmp protocol
	- samba << file sharing with Windows, Mac and Linux
