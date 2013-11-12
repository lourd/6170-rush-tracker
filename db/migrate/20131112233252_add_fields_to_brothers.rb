class AddFieldsToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :firstname, :string
    add_column :brothers, :lastname, :string
    add_column :brothers, :fraternity_id, :integer
    add_column :brothers, :is_admin, :boolean, :default => false
    add_column :brothers, :is_verified, :boolean, :default => false
  end
end
