class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :brother_id
      t.integer :rushee_id
      t.text :text

      t.timestamps
    end
  end
end
