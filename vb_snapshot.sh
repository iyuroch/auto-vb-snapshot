#!/bin/bash


NOW=`date +%Y-%m-%d-T%H:%M:%S`
VB_NAME=$1
SNAPSHOT_NAME="autosnap_$NOW"
SNAPSHOT_DESCRIPTION='automated snapshot system'

#check if virtual machine is running
if ! $(vboxmanage showvminfo $VB_NAME | grep -q active/running); then
	echo "not running"
	exit 1
fi

echo "running, making snapshot"

#make snapshot of VM
vboxmanage snapshot "$VB_NAME" take "$SNAPSHOT_NAME" --description "$SNAPSHOT_DESCRIPTION" >/dev/null

#make list of all snapshots, our script made
while read full_line; do
	SNAPSHOTS+=($(echo $full_line | awk -F= '{ print $2 }' | sed -e 's/"//g' ))
done < <(vboxmanage snapshot ubuntu_snapshot list --machinereadable | grep -v 'Current' | grep -E 'SnapshotName.*autosnap' ) 

#iterate over snaphots, and delete latest one
SNAPSHOTS_ARR="${#SNAPSHOTS[@]}"
if [[ $SNAPSHOTS_ARR>3 ]]; then
	for i in `seq 0 $( expr $SNAPSHOTS_ARR - 4)`; do
		echo "removing snapshot ${SNAPSHOTS[$i]}"
		vboxmanage snapshot $VB_NAME delete ${SNAPSHOTS[$i]}
	done
fi
