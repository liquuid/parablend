#!/bin/bash
kill -9 `ps aux | grep "blender-bin -b" | grep -v grep | awk '{print $2}'`
rm -rf /storage/temp/*
