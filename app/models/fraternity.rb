class Fraternity < ActiveRecord::Base

	has_many :brothers
	has_many :events

end
