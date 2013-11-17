class Comment < ActiveRecord::Base

	belongs_to :rushee
	belongs_to :brother

	validates :brother, :rushee, :text, presence: true

end
