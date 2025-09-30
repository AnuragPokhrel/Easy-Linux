#!/bin/bash
# This was created as hobby only. If anything goes wrong, you're responsible.
say() {
    text=$1
    delay=${2:-0.001}
    for ((i=0 ;i<${#text}; i++))
    do
    printf "%s" "${text:i:1}"
    sleep $delay
    
done
echo
}
say "This is a simple program to make backups a lot easier. Please follow the instructions."
say "Just open the terminal in the directory you want to backup, and run the command backup if you've set it globally. If not, just run the file. and answer the prompted questions."
if [ ! -f /usr/local/bin/backup ]
then
say "It seems like this script isn't installed yet. Do you want to move it to /usr/local/bin/?"
say "This wil make it easier for you to use this tool, since you can just use 'backup' to backup"
say "[y/n]"
read ch
if [[ $ch =~ ^[yY]$ ]]
then
sc="$( readlink -f "$0")"
sudo cp "$sc" /usr/local/bin/backup
sudo chmod +x /usr/local/bin/backup
fi
fi
if [ ! -d ~/Backups ]
then
mkdir -p ~/Backups
fi
if [ ! -f ~/Backups/log.txt ]
then
touch ~/Backups/log.txt
fi
datest=$(date +"%Y-%m-%d_%H-%M-%S")
say "You want to backup current folder? [y/n]"
read in
filename=$(basename "$PWD")
if [[ $in =~ ^[yY]$ ]]
then
say "Do you want to compress them? [y/n]"
read comp
if [[ $comp =~ ^[yY]$ ]]
then 
name="${filename}-$datest.tar.xz"
tar -cJf  "$HOME/Backups/$name" .
echo "All the files in ${filename} were compressed and backed up in $HOME/Backups/${filename}-$datest.tar.xz at $(date) . " >> $HOME/Backups/log.txt
else
cp -r "$PWD" "$HOME/Backups/${filename}-$datest"
say "Done. You can check details in $HOME/Backups/log.txt"
echo "All the files in ${filename} were backed up in $HOME/Backups/${filename}-$datest at $(date) . " >> $HOME/Backups/log.txt
fi
else
say "Okay, exiting."
fi