class Fraternity < ActiveRecord::Base

	has_many :brothers
	has_many :events
	has_many :rushees

	def verified_brothers 
    	return self.brothers.where :is_verified => true
  	end

  	def pending_brothers
  		return self.brothers.where :is_verified => false
  	end

end
