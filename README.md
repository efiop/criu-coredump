# criu-coredump
Generate valid core dump from CRIU images.

# Description

CRIU images contain lots of information about process state.
In fact, it is sufficient enough to generate a valid core dump
which can be later be used by gdb, for example. criu-coredump
does exactly that, it takes a directory with CRIU images and
produces Elf core dumps.

Basically, you can use CRIU to checkpoint task when you need it
(i.e. when it hangs, or when an error occures) or make your
application call CRIU via one of its interfaces(CLI, RPC or C
library) and then produce core dump and inspect it via gdb.

To generate core dump of your application you don't even need
to be a root, it is enough for you to be the owner of that task.
For that all you have two choices:
    1) Use CRIU service running and use RPC[1] or libcriu[2]. It
       is useful if you want your app to automatically call CRIU.
    2) Use CRIU binary with suid bit set. 

[1] http://criu.org/RPC
[2] http://criu.org/C_API

criu-coredump project provides both cmdline tool and python
module(criu_coredump), so you can use it in your python apps.

# Limitations

For now only x86_64 is supported. The matter of supporting other
architectures supported by CRIU is to use proper constants in
elf header and provide proper arch-dependent notes.

Some notes in coredump are not fullfilled(i.e. SIGINFO).

VVAR and VSYSCALL vmas are just filled with zeroes, as CRIU
doesn't currently provide them. VVAR is a tricky one and
gdb also has problems dumping it[1]. VSYSCALL in theory could
just be read from current process, so it should be quite easy
to fix.

[1] https://lkml.org/lkml/2015/3/12/439

# Installation

	$ python setup.py install

# Usage

	criu-coredump [-h] [-i IN] [-p PID] [-o OUT]
	
	optional arguments:
	  -h, --help         show this help message and exit
	  -i IN, --in IN     directory where to get images from.
	  -p PID, --pid PID  generate core dump of a process identified by PID.
	                     If not specified -- generating for each pid.
	  -o OUT, --out OUT  directory to write core dump to.

# Contribute

The prefered way to send patches is through criu mailing list. For example,
if you want to send 3 of your last commits just run:

	$ git send-email -s -3 --to=criu@openvz.org
