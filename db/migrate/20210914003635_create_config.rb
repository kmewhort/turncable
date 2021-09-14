class CreateConfig < ActiveRecord::Migration[6.1]
  def change
    create_table :configs do |t|
      t.string :spotify_device
    end
  end
end
