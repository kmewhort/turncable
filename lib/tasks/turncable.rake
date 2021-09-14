namespace :turncable do
  task :check_disc => :environment do
    current_disc = Disc.find_from_current_card
    most_recently_played = Disc.most_recently_played
    
    spotify_client = ::SpotifyClient.new

    if current_disc && current_disc.spotify_uri != spotify_client.current_item_uri && Disc.changable?
      spotify_client.play_item!(Config.get.spotify_device, current_disc.spotify_uri)
      current_disc.update_attribute(:most_recently_played_at, Time.now)
    end
  end
end
