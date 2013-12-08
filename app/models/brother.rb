class Brother < ActiveRecord::Base

  belongs_to  :fraternity
	has_many :action_brothers
	has_many :actions, through: :action_brothers
	has_many :comments
	has_many :approvals
	has_many :rushees, foreign_key: :primary_contact_id


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # returns all verified brothers in a frat
  # DEPRECATED -- use current_brother.fraternity.brothers
  def self.findAllByFraternityID fraternity_id
    return self.where :fraternity_id => fraternity_id, :is_verified => true
  end

  # returns all unverified brothers in a frat
  # @deprecated - use fraternity.pending_brothers
  def self.findAllPendingByFraternityID fraternity_id
    return self.where :fraternity_id => fraternity_id, :is_verified => false
  end

  # make is_verified true
  def self.verify id
    bro = Brother.find id
    bro.is_verified = true
    bro.save() 
  end


 ##Methods to modificed a Rushee's associated Approvals. 

  # Verifies an approval exists between a brother and the matching rushee
  # If there is not one, the method creates new approval
  def verifyApproval(rushee)
    if !self.approvals.find_by(rushee: rushee)
      self.approvals.create(rushee: rushee)
    end
  end

  # Mark Rushee as Met by Brother
  def meet(rushee)
    verifyApproval(rushee)
    self.approvals.find_by(rushee: rushee).update_attribute("met", true)
  end

  def unmeet(brother)
    verifyApproval(rushee)    
    self.approvals.find_by(rushee: rushee).update_attribute("met", false)
  end

  #Change Votes for Rushee
  def upVote(rushee)
    verifyApproval(rushee)
    self.approvals.find_by(rushee: rushee).update_attribute("vote", true)   
  end   
  
  def removeVote(rushee)
    verifyApproval(rushee)    
    self.approvals.find_by(rushee: rushee).update_attribute("vote", false)
  end
end
