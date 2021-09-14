class AddLastPlayTime < ActiveRecord::Migration[6.1]
  def change
    add_column :discs, :last_played_at, :datetime
  end
end
