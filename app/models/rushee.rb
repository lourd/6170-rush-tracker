class Rushee < ActiveRecord::Base

	belongs_to :fraternity
	belongs_to :primary_contact, class_name: "Brother"
	has_many :attendances
	has_many :events, through: :attendances, order: 'date desc'
	has_many :actions
	has_many :comments
	has_many :approvals


  validates :email, uniqueness: true, case_sensitive: false, allow_blank: true
  validates :cellphone, uniqueness: true, allow_blank: true
  validates :firstname, presence: true

  def self.findAllByPrimaryContactID id
    self.where :primary_contact_id => id
  end

  # Associates the :picture attribute with an attached file
  has_attached_file :picture, styles: {
	    thumb: '100x100>',
	    square: '200x200#',
	    medium: '300x300>'
	  }

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

  def primaryContactName
    if primary_contact
      primary_contact.firstname + " " + primary_contact.lastname
    else
      "Unassigned"
    end
  end

  # Assumes the name is given is the full name
  def self.findByName(name)
    firstName = name.split()[0]
    lastName = name.split()[1]
    return Rushee.find_by(firstname: firstName, lastname: lastName)
  end

  def self.findByEmail(email)
    return Rushee.find_by(email: email)
  end

end
