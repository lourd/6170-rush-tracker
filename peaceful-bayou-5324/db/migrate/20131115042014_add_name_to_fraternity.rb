class AddNameToFraternity < ActiveRecord::Migration
  def change
  	add_column :fraternities, :name, :string
  end
end
