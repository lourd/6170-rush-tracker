class CreateFraternities < ActiveRecord::Migration
  def change
    create_table :fraternities do |t|

      t.timestamps
    end
  end
end
