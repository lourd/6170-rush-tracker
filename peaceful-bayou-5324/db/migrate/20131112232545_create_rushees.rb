class CreateRushees < ActiveRecord::Migration
  def change
    create_table :rushees do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :cellphone
      t.string :facebook_url
      t.string :twitter_url
      t.string :profile_picture_url
      t.string :dorm
      t.string :room_number
      t.string :hometown
      t.string :sports
      t.string :frats_rushing
      t.integer :primary_contact_id
      t.string :action_status
      t.string :bid_status

      t.timestamps
    end
  end
end
