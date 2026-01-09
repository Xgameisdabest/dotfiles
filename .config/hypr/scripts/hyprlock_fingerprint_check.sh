#!/bin/bash
if [[ ! -z $(fprintd-list $USER 2>/dev/null) ]] || [[ $(fprintd-list $USER) =~ "No devices available" ]]; then
	echo "."
fi
