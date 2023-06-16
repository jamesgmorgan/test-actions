#!/bin/bash

while true; do
    ps -eo user,pid,rss,command --sort=rss | grep -v grep | grep -v docker | grep perl
    sleep 1
Done
