# auto-vb-snapshot
Uses cron to automaticaly create snapshot of chosen virtual machine. Automatically install itself via installer.sh

To use run in cli:
chmod +x isntaller.sh
./installer.sh install

and follow installation process

On default it rotates snapshot once per hour. Change in your user crontab to change this.

./installer.sh uninstall

And follow all suggestions to remove rotations.
