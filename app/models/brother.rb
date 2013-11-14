class Brother < ActiveRecord::Base
	has_many :action_brothers
	has_many :actions, through: :action_brothers
	has_many :comments
	has_many :approvals
	has_many :rushees, :foreign_key => "primary_contact_id"


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # returns all verified brothers in a frat
  def self.findAllByFraternityID fraternity_id
    return self.where :fraternity_id => fraternity_id, :is_verified => true
  end

  # returns all unverified brothers in a frat
  def self.findAllPendingByFraternityID fraternity_id
    return self.where :fraternity_id => fraternity_id, :is_verified => false
  end
end
