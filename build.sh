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
	##  uncomment the following to fetch stage3
	##  otherwise modify `ToolsTree=` and point it to your stage3
	# fetch_stage3
 	##  uncomment this if you want to use and you don't have it installed
 	##  mkosi
	# get_9999
	## uncomment this to build with mkosi; otherwise see the list of
	## `Packages=` define in ## `mkosi.images/base/mkosi.conf`
	# build
}

main
