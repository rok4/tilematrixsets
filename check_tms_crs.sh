#!/bin/bash

for crs in $(jq -r .crs *.json | sort | uniq); do
	projinfo $crs >/dev/null 2>/dev/null
	if [[ $? != 0 ]]; then
		echo "$crs inconnu pour PROJ"
		echo "TMS concerné(s) :"
		ack -l "$crs"
		echo ""
	fi
done