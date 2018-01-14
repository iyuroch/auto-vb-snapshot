#!/bin/bash
#installs cronjob to make automate snapshots and their rotation
#type install

if [ $# -eq 0 ]; then
	echo "Usage: install/uninstall"
fi

AUTO_SNAPSHOT='vb_snapshot.sh'

function install() {
	SCRIPT_DIR=`realpath $0`
	echo -n "Enter name of virtual machine and press [ENTER]: "
	read VM_NAME
       	cp "$AUTO_SNAPSHOT" ~
	chmod +x "$HOME/$AUTO_SNAPSHOT"
	#crontab -e >/dev/null
	crontab -l 2>/dev/null > mycron
	echo "00 */1 * * * ~/$AUTO_SNAPSHOT $VM_NAME" >> mycron
	crontab mycron
	rm mycron
}

function uninstall() {
	echo "If you don't have auto-snapshots for other vmachines feel free to rm ~/$AUTO_SNAPHOST"
	echo "Check your crontab and remove according cronjob"
}

"$@"
