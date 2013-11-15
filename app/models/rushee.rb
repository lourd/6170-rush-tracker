class Rushee < ActiveRecord::Base

	belongs_to :brother, :foreign_key => "primary_contact_id"
	has_many :attendances
	has_many :events, through: :attendances
	has_many :actions
	has_many :comments
	has_many :approvals

	def self.findAllByFraternityID fraternity_id
        return self.where :fraternity_id => fraternity_id
    end

end
