#!/bin/bash

set -euo pipefail

pushd ~/Projects/jensraaby
	[[ ! -d wifi-location-changer ]] && git clone git@github.com:jensraaby/wifi-location-changer.git
	
	pushd wifi-location-changer
		git fetch --all --prune
		git checkout jens/bbc
		./install.sh
	popd
popd


		
