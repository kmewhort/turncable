class CreateDisc < ActiveRecord::Migration[6.1]
  def change
    create_table :discs do |t|
      t.string :nfc_uuid
      t.string :spotify_uri
    end
  end
end
