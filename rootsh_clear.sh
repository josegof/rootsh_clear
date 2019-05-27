#!/bin/bash

##########################################################################
# rootsh_splunk.sh
#
# Script to close rootsh sessions and strip ansi escape codes
#
##########################################################################

RSHBIN=`which rootsh`
ANFBIN=`which ansifilter`
#DECBIN=`which declutter`
DECBIN="/root/declutter"
LOGDIR=`$RSHBIN -V | grep "logfiles.*directory" | sed 's/.*directory \(.*\)/\1/'`

# workaround to redo old files
if [ ! -f "$LOGDIR/.splunkok" ]; then
 rm $LOGDIR/*.spl
 touch "$LOGDIR/.splunkok"
fi

find $LOGDIR -type f -not -name '*.closed' -not -name '*.spl' -not -name '.*' |
 while IFS= read RSHLOG; do
   RSHPID=$(fuser $RSHLOG 2> /dev/null)
    if [ -z "$RSHPID" ]; then
     mv "$RSHLOG" "${RSHLOG}.closed"
    fi
  done

find $LOGDIR -type f -name '*.closed' -not -name '.*' |
 while IFS= read RSHLOG; do
    if [ ! -s "${RSHLOG}.spl" ]; then
     $DECBIN $RSHLOG | $ANFBIN > "${RSHLOG}.spl"
     chmod 600 ${RSHLOG}.spl
     touch -c --reference="$RSHLOG" "${RSHLOG}.spl"
    fi
  done
