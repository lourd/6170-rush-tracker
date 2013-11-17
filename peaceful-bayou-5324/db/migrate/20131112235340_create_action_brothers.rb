class CreateActionBrothers < ActiveRecord::Migration
  def change
    create_table :action_brothers do |t|
      t.integer :action_id
      t.integer :brother_id

      t.timestamps
    end
  end
end
