require 'spotify'

config_dir = File.dirname(__FILE__) + '/config'
app_json = JSON.parse IO.read("#{config_dir}/spotify_app.json")

account = Spotify::Accounts.new
account.client_id = app_json['client_id']
account.client_secret = app_json['client_secret']
account.redirect_uri = app_json['redirect_uri']

puts "Step 1. Add #{account.redirect_uri} to your app at https://developer.spotify.com/dashboard. Press return to continue.\n\n"
wait = gets

puts "Step 2. Authorize at #{account.authorize_url} and enter the returned 'code' parameter from the example.com URL below:\n"
code = gets
session = account.exchange_for_session(code.strip)
puts "\nInitial session created, expires at #{session.expires_at}.\n"

refresh_token = session.refresh_token
puts "Refresh token retrieved: #{refresh_token}\n"

File.write "#{config_dir}/spotify_auth.json", JSON.pretty_generate({ refresh_token: refresh_token })
puts "Refresh token written to config/spotify_auth.json\n"
