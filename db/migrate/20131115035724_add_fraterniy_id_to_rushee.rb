class AddFraterniyIdToRushee < ActiveRecord::Migration
  def change
    add_column :rushees, :fraternity_id, :integer
  end
end
