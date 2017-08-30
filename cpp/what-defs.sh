#!/bin/sh

# what-defs: prints names of predefined cpp macros
# tested on Sun3, Sun4, SGI, HP, Stellar, Convex, DECstation, Moto 1147

# Apparently by Greg Roelofs, a.k.a "Cave Newt"

# stupid, stupid Ultrix! I have a "which" function that I cannot use, because
# the Ultrix /bin/sh does not understand shell functions! (try /bin/sh5!)
# also, the Ultrix "test" command does not understand the -x flag!

path="`echo $PATH | sed -e 's/:/ /g'`"
cc=`for dir in $path ; do
    if [ -r $dir/cc ] ; then
	echo $dir/cc
	exit
    fi
done`

strings -a -2 /lib/cpp $cc |
sed -e 's/^-D//' |
sort -u |
sed -n '/^[a-zA-Z_][a-zA-Z0-9_]*$/s//#ifdef &\
"%&"\
#endif/p' >/tmp/$$.c

cc -E /tmp/$$.c |
sed -n '/%/s/[%"]//gp'

rm -f /tmp/$$.c
exit 0
