#!/bin/sh

#This script needs dmenu and simple-mtpfs to work, so you have to install them before you start using this script

android=$(simple-mtpfs -l)
choose="$(echo "$android" | dmenu -i -p "Which Android device?")"
device="$(echo "$choose" | cut -d : -f 1)"


androiddev=$(simple-mtpfs -l | cut -d ' ' -f 2)
mountpoint="$(printf "$androiddev" | dmenu -i -p "Which mountpoint?")"
mkdir -p ~/Cell/$androiddev && mp=~/Cell/$androiddev


echo "OK" | dmenu -i -p "Tap Allow on your phone if it asks for permission and then press enter"


mtumt="$(printf "Mount\nUnmount" | dmenu -i -p "Do you want mount or unmount your device?")"
case "$mtumt" in
	Mount) simple-mtpfs --device $device $mp
	;;
	Unmount) fusermount -u $mp && rmdir ~/Cell/$androiddev
	;;
esac
