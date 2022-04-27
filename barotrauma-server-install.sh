#! /bin/bash

# script to install the barotrauma dedicated server to a
# linux vps running ubuntu18.04 and steamcmd

# login to steam publicly and install the game and server apps
steamcmd +login anonymous +app_update 602960 +app_update 1026340 +quit
#and exit steam back into shell

BTDS="/home/steam/.steam/steamapps/common/Barotrauma Dedicated Server"

# check that all paths are in place
echo 'checking required paths'

if [[ ! -d /home/steam/.steam/sdk64 ]]; then
	echo 'directory /home/steam/.steam/sdk64/ does not exist'
	echo 'creating ...'
	mkdir /home/steam/.steam/sdk64;
fi
if [[ ! -f /home/steam/.steam/sdk64/steamclient.so ]]; then
	ln -s "${BTDS}"/linux64/steamclient.so  /home/steam/.steam/sdk64/
fi

cd "${BTDS}"
ModsFolder=("Daedalic Entertainment GmbH" "Barotrauma" "WorkshopMods" "Installed")

for f in "${ModsFolder[@]}"; do
	echo "checking for $BTDS/$f"
	if [[ ! -f "${f}" ]]; then
		echo 'Not found. Creating now...'
		mkdir "${f}"
	fi
	cd "${f}"
done


# this needs to be linked into /home/steam/.local/share/
# by default this no longer spawns on its own
# and needs to be created if still missing
echo 'going home'
cd $HOME
echo 'checking for /home/steam/.local/share'
if [[ ! -d /home/steam/.local ]]; then
	mkdir .local
	echo '.local created'
	cd .local
fi
if [[ ! -d share ]]; then
	mkdir share
	echo '/home/steam/.local/share created'
	cd share
fi

if [[ ! -d /home/steam/.local/share/Daedalic\ Entertainment\ GmbH ]]; then
	ln -s "${BTDS}"/Daedalic\ Entertainment\ GmbH/ .
fi
