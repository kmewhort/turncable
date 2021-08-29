class Disc < ApplicationRecord
  validates :nfc_uuid, uniqueness: true, presence: true
end
