class Fraternity < ActiveRecord::Base

	has_many :brothers
	has_many :events
	has_many :rushees

end
