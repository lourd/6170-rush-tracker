class ChangeProfilePictureUrlToPicture < ActiveRecord::Migration
  def change
  	rename_column :rushees, :profile_picture_url, :picture
  end
end
