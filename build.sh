#!/usr/bin/env sh

# this script file and/or its output should be made into a wiki page for `mkosi`

set -ex
set -o nounset

usage() {
	printf "build.sh [-f[f] \n" && exit
}

get_9999() {
	# TODO: possibly warn for sudo here
	sudo eselect repository enable 9999 || true
	sudo emaint sync -r 9999 || true
}

fetch_stage3() {
	# FIXME: this is bound to fail
	sudo emerge -1 '=app-admin/mkosi-9999::9999' || true
	mkosi-getstage3
}

build() {
	ulimit -n 65534
	mkosi --incremental=yes --debug --debug-shell -ff build
}

main() {
	# check if user needs 9999
	get_9999 && fetch_stage3
	build
}

main
