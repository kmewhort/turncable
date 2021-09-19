class AddDuration < ActiveRecord::Migration[6.1]
  def change
    add_column :discs, :playback_duration_ms, :integer 
  end
end
