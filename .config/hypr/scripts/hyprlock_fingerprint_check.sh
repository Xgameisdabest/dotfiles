#!/bin/bash
if [[ ! -z $(fprintd-list $USER 2>/dev/null) ]]; then
	echo "."
fi
