class AddFraternityIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fraternity_id, :integer
  end
end
