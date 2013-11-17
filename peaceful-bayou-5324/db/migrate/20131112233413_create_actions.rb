class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :brother_id
      t.integer :rushee_id
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
