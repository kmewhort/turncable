#!/bin/bash
while true
do
  /home/pi/.rvm/bin/rvm in /home/pi/turncable do bundle exec rake turncable:check_disc
  sleep 10
done
