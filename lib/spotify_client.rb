require 'spotify'

class SpotifyClient
  CONFIG_DIR = File.dirname(__FILE__) + '/config'

  def api
    Spotify::SDK.new(session)
  end

  def session
    @session ||= Spotify::Accounts::Session.from_refresh_token(account, auth_json['refresh_token'])
    @session.refresh! if @session.expired? || @session.expired?.nil?
    @session
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

