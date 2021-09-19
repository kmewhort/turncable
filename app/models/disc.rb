class Disc < ApplicationRecord
  validates :nfc_uuid, uniqueness: true, presence: true
  validates :spotify_uri, presence: true

  def self.find_from_current_card
    require 'taptag'
    require 'taptag/nfc'
    Taptag::NFC.interface_type = :i2c
    card = Taptag::NFC.card_uid&.pack('c*')&.unpack1('H*')
    Disc.find_by(nfc_uuid: card)
  end

  def self.most_recently_played
    self.where.not(last_played_at: nil).order(last_played_at: :desc).limit(1).first
  end

  def self.changeable?
    most_recent = most_recently_played
    most_recent.blank? || (most_recent.last_played_at+(most_recent.playback_duration_ms.to_f/1000).seconds < Time.now)
  end
end
