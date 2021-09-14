#!/bin/bash
#export RAILS_ENV=production
sudo /home/pi/.rvm/bin/rvm in /home/pi/turncable do bundle exec rails s --binding 0.0.0.0 -p80 2>&1 | tee /home/pi/turncable/log/startup.log
