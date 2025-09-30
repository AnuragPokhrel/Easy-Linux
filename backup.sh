#!/bin/bash
# This was created as hobby only. If anything goes wrong, you're responsible.
type () {
    text=$1
    delay=${2:-0.01}
    for ((i=0 ;i<${#text}; i++))
    do
    printf "%s" "${text:i:1}"
    sleep $delay
    
done
echo
}
type "This is a simple program to make backups a lot easier. Please follow the instructions."
type "Just open the terminal in the directory you want to backup, and run the script. and answer the prompted questions."
if [ ! -d ~/Backups ]
then
mkdir -p ~/Backups
fi
if [ ! -f ~/Backups/log.txt ]
then
touch ~/Backups/log.txt
fi
type "You want to backup current folder? [y/n]"
read in
filename=$(basename "$PWD")
if [[ $in =~ ^[yY]$ ]]
then
type "Enter one word tag, this will be put after name, used to differentiate different versions"
read tag
cp -r "$PWD" "$HOME/Backups/${filename}-${tag}"
type "Done. You can check details in ~/Backups/log.txt"
echo " ${tag} All the files in ${filename} were backed up in $HOME/Backups/${filename}-${tag} at $(date) . " >> $HOME/Backups/log.txt
fi