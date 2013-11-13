class Approval < ActiveRecord::Base

	belongs_to :rushee
	belongs_to :brother

	validates :rushee, presence: true
	validates :brother, presence: true, :uniqueness => { :scope => :rushee}

end
