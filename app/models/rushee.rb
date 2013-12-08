class Rushee < ActiveRecord::Base

	belongs_to :fraternity
	belongs_to :brother, :foreign_key => "primary_contact_id"
	has_many :attendances
	has_many :events, through: :attendances
	has_many :actions
	has_many :comments
	has_many :approvals


  validates :email, uniqueness: true, case_sensitive: false, allow_blank: true
  validates :cellphone, uniqueness: true, allow_blank: true
  validates :firstname, presence: true

  attr_accessor :primary_contact_brother

  def self.findAllByPrimaryContactID id
    self.where :primary_contact_id => id
  end

  # Associates the :picture attribute with an attached file
  has_attached_file :picture, styles: {
	    thumb: '100x100>',
	    square: '200x200#',
	    medium: '300x300>'
	  }


  def assignedBrother
    if self.brother
      brother.firstname + " "+ brother.lastname
    else
      "Unassigned"
    end
  end

  def brother_approval b_id
    self.approvals.find_by brother_id: b_id
  end

  def validActionSelectStatuses
    return [["None", "None"], ["Stay the Course", "Stay the Course"], 
      ["Push Harder", "Push Harder"], ["Repudiate", "Repudiate"]]
  end

  def validBidSelectStatuses
    return [["None", "None"], ["Offered", "Offered"], ["Accepted", "Accepted"], ["Rejected", "Rejected"]]
  end

  def validActionStatuses
    return ["None", "Stay the Course", "Push Harder", "Repudiate"]
  end

  def validBidStatuses
    return ["None", "Offered", "Accepted", "Rejected"]
  end
end
