#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install build-essential htop manpages-dev manpages-posix manpages-posix-dev freebsd-manpages git libssl-dev g++
sudo apt-get autoremove

exit

