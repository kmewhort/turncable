class Disc < ApplicationRecord
  validates :nfc_uuid, uniqueness: true, presence: true
  validates :spotify_uri, presence: true

  DISC_CHANGE_MINIMUM = 60.seconds

  def self.find_from_current_card
    require 'taptag'
    require 'taptag/nfc'
    Taptag::NFC.interface_type = :i2c
    card = Taptag::NFC.card_uid&.pack('c*')&.unpack1('H*')
    Disc.find_by(nfc_uuid: card)
  end

  def self.most_recently_played
    self.order(last_played_at: :desc).limit(1).first
  end

  def self.changable?
    most_recent = most_recently_played
    most_recently_played.blank? || most_recently_played.last_played_at < Time.now-60.seconds
  end
end
