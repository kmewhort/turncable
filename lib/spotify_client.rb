require 'spotify'

class SpotifyClient
  CONFIG_DIR = File.dirname(__FILE__) + '/../config'

  def api
    Spotify::SDK.new(session)
  end

  def session
    @session ||= Spotify::Accounts::Session.from_refresh_token(account, auth_json['refresh_token'])
    @session.refresh! if @session.expired? || @session.expired?.nil?
    @session
  end

  def current_artist_name(from_cache = true)
    @current_artist_name = nil unless from_cache
    @current_artist_name ||= api.connect.playback.artists.first.name
  rescue RuntimeError => e
    # nothing playing
    nil
  end

  def current_item_name(from_cache = true)
    @current_track_name = nil unless from_cache
    @current_track_name ||= api.connect.playback.item.name
  rescue RuntimeError => e
    # nothing playing
    nil
  end

  def current_item_uri(from_cache = true)
    @current_item_uri = nil unless from_cache
    @current_item_uri = api.connect.playback.item.uri
  rescue RuntimeError => e
    # nothing playing
    nil
  end

  def current_item_duration
    api.connect.playback.item.duration_ms
  end

  def play_item!(device_id, uri)
    api.connect.devices.each do |device|
      if device.id == device_id
        api.connect.devices[0].play!({
          uri: uri,
          position_ms: 0
        })
        return
      end
    end
  end

  def devices
    api.connect.devices
  end

  private

  def app_json
    @app_json ||= JSON.parse IO.read("#{CONFIG_DIR}/spotify_app.json")
  end

  def auth_json
    @auth_json ||= JSON.parse IO.read("#{CONFIG_DIR}/spotify_auth.json")
  end

  def account
    @account ||= begin
      a = Spotify::Accounts.new
      a.client_id = app_json['client_id']
      a.client_secret = app_json['client_secret']
      a.redirect_uri = app_json['redirect_uri']
      a
    end 
  end
end

