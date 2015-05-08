#!/bin/bash

set -e

echo "= Launch loop"
setsid ./loop --fakeopt1 --fakeopt2 </dev/null &>/dev/null &
PID=$!
echo "= done. Loop pid $PID"

echo "= Dump loop"
criu dump -v4 -o dump.log -D ./ -t ${PID} --shell-job
echo "= done"

images_list=$(ls -1 *.img)

function _exit {
	if [ $? -ne 0 ]; then
		echo "FAIL"
		exit -1
	fi
}

function core_dump {
	echo "= Test core dump"

	echo "=== img to core dump"
	../criu-coredump -i ./ -o ./
	echo "=== done"

	cores=$(ls -1 core.*)
	for x in $cores
	do
		echo "=== try readelf $x"
		readelf -a $x
		echo "=== done"
	done

	echo "= done"
}

core_dump
