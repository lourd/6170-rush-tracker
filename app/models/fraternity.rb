class Fraternity < ActiveRecord::Base

	has_many :brothers
	has_many :events
	has_many :rushees

	def self.verified_brothers 
    	return self.brothers.where :is_verified => true
  	end

end
