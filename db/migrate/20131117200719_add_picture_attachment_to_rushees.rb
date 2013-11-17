class AddPictureAttachmentToRushees < ActiveRecord::Migration
  def change
  	add_attachment :rushees, :picture
  end
end
