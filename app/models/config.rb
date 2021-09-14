class Config < ApplicationRecord
  def self.get
    Config.first || Config.create!
  end
end
