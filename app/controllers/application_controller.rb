require 'spotify_client'

class ApplicationController < ActionController::Base
  helper_method :spotify_client, :nfc

  def index
    @current_card = nfc&.card_uid&.pack('c*')&.unpack1('H*')
    @current_disc = Disc.find_by(nfc_uuid: @current_card)
  end

  def record 
    @disc = Disc.find_or_initialize_by(nfc_uuid: params[:nfc_uuid]) 
    @disc.spotify_uri = params[:spotify_uri]
    if !@disc.save
      flash[:error] = "Unable to record: #{@disc.errors.full_messages}"
    else
      flash[:success] = "#{params[:spotify_uri]} recorded to #{params[:nfc_uuid]}" 
    end
    redirect_to application_path
  end

  def set_device
    Config.get.update_attribute(:spotify_device, params[:spotify_device])
    redirect_to application_path
  end

  protected
  def spotify_client
    @spotify_client ||= ::SpotifyClient.new
  end

  def nfc
    return nil unless ENV['ENABLE_NFC']
    require 'taptag'
    require 'taptag/nfc'
    Taptag::NFC.interface_type = :i2c
    Taptag::NFC
  end
end
