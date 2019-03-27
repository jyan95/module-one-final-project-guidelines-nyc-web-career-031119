class AddStreakColumnToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :streak, :integer
  end
end
