#!/bin/bash
for i in `\ls -d /storage/.parablend/1*`;do echo $i: `cat $i/status`;done
