#!/bin/sh

PUBKEY=$1
KEYDIR="/home/ubuntu/.ssh"

if [ ! -d $KEYDIR ]; then
  mkdir $KEYDIR
  chmod 700 $KEYDIR
  chown ubuntu:ubuntu $KEYDIR
fi

if [ ! -f $KEYDIR/authorized_keys ]; then
  echo $PUBKEY >> $KEYDIR/authorized_keys
  chmod 600 $KEYDIR/authorized_keys
fi
