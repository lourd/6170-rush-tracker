class Event < ActiveRecord::Base

	has_many :attendances
	has_many :rushees, through: :attendances

end
