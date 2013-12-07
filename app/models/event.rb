class Event < ActiveRecord::Base

	belongs_to	:fraternity
	has_many :attendances
	has_many :rushees, through: :attendances

  validates :date, presence: true
  validates :name, presence: true

    def self.findAllByFraternityID fraternity_id
      return self.where :fraternity_id => fraternity_id
    end

    def addRushee(rushee)
      Attendance.create(event_id: self.id, rushee_id: rushee.id)
    end   
end
