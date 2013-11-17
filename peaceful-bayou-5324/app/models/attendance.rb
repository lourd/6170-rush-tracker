class Attendance < ActiveRecord::Base

	belongs_to 	:rushee
	belongs_to	:event

	validates :event_id, presence: true, :uniqueness => { :scope => :rushee_id} 

end
