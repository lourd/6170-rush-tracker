class Rushee < ActiveRecord::Base

	belongs_to :fraternity
	belongs_to :primary_contact, class_name: "Brother"
	has_many :attendances, dependent: :destroy
	has_many :events, through: :attendances, order: 'date desc'
	has_many :actions, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :approvals, dependent: :destroy


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

  ##Methods to Get Full Names
  def primaryContactName
    if primary_contact
      primary_contact.firstname + " " + primary_contact.lastname
    else
      "Unassigned"
    end
  end

  def fullName
    firstname + " " + lastname
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

  #Get Facebook Image URL
  def facebookProfilePicURL
    #   https://www.facebook.com/user_name
    if facebook_url
      return "https://graph.facebook.com/[PROFILE_ID]/picture"
    else
      None
    end
  end

  ##Get Approval Counts
  def metBrotherCount
    self.approvals.where(met: true).count
  end

  def upVoteCount
    self.approvals.where(vote: true).count
  end

  def full_name
    self.firstname + " " + self.lastname
  end

end
