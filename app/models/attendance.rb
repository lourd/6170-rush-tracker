class Attendance < ActiveRecord::Base

	belongs_to 	:rushee
	belongs_to	:event

	validates :event
	validates :rushee, presence: true, :uniqueness => { :scope => :event} 

end
