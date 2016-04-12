#!/usr/bin/env bash 

. hbase-hbase-config.sh
hbase-daemon.sh --config ../conf/ foreground_start master
