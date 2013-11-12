class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :brother_id
      t.integer :rushee_id
      t.boolean :vote
      t.boolean :met

      t.timestamps
    end
  end
end
