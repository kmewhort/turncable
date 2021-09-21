# Turncable

# Installation

## Prerequisites

### Hardware
* Rasberry Pi
* NFC hat

### Software
* Ruby 2.7.4
* Bundler
* Yarn
* Sqlite3


## Download

```
git clone git@github.com:kmewhort/turncable
cd turncable
bundle install 
```

## Database setup

```
bundle exec rake db:create db:schema:load
```

## Spotify setup

You'll need two types of credentials:
1. Developer credentials for your local application
2. User oauth credentials authorizing that app to use your spotify account. 

### Developer credentials

* Register at [developer.spotify.com](https://developer.spotify.com/) to generate a new Client ID and Client Secret.
* Add these credentials to `config/spotify_app.json`

### Account credentials

* Run `bundle exec lib/authorize_spotify.rb` and follow the instructions. The end result will be your secret written to `config/spotify_auth.json`

## Servers

To automatically startup the webserver admin page at boot, on port 80, have Puma run the rails app using systemd:
* `sudo cp turncableserver.service /lib/systemd/system/`
* `sudo systemctl enable turncableserver.service`
* `sudo systemctl start turncableserver` or reboot

You can also directly run the server with `bundle exec rails s -p<desired port>`. You'll need to sudo if you want port 80.

To automatically startup the worker that checks for new NFC discs and changes tracks on spotify:
* `sudo cp turncableserver.service /lib/systemd/system/`
* `sudo systemctl enable turncableworker.service`
* `sudo systemctl start turncablewoker` or reboot

You can manually run it with `./worker.sh` (it runs a rake test every 10 seconds).

## Playing audio through your RPi (including via bluetooth) 

Turncable will play to any current device connected to spotify. To make your rasberry device that device, I recommend [raspotify](`https://github.com/dtcooper/raspotify`). 

Also note that bluetooth on RPis are a bit fiddly.  I highly recommend [pi-btaudio](`https://github.com/bablokb/pi-btaudio`) -- it was the only method I could get working after a couple hours of attempts.
