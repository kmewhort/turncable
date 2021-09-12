class Disc < ApplicationRecord
  validates :nfc_uuid, uniqueness: true, presence: true
  validates :spotify_uri, presence: true
end
