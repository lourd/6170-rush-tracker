class Event < ActiveRecord::Base

	has_many :attendances
	has_many :rushees, through: :attendances

        def self.findAllByFraternityID fraternity_id
          return self.where :fraternity_id => fraternity_id
        end
end
