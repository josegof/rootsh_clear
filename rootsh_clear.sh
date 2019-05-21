#!/bin/bash

##########################################################################
# rootsh_splunk.sh
#
# Script to close rootsh sessions and strip ansi escape codes
#
##########################################################################

RSHBIN=`which rootsh`
ANFBIN=`which ansifilter`
LOGDIR=`$RSHBIN -V | grep "logfiles.*directory" | sed 's/.*directory \(.*\)/\1/'`

find $LOGDIR -type f ! -name '*.closed' ! -name '*.spl' |
 while IFS= read RSHLOG; do
   RSHPID=$(fuser $RSHLOG 2> /dev/null)
    if [ -z "$RSHPID" ]; then
     mv "$RSHLOG" "${RSHLOG}.closed"
    fi
  done

find $LOGDIR -type f -name '*.closed' |
 while IFS= read RSHLOG; do
    if [ ! -s "${RSHLOG}.spl" ]; then
    cat $RSHLOG | $ANFBIN > "${RSHLOG}.spl"
    fi
  done
