class Rushee < ActiveRecord::Base

	belongs_to :fraternity
	belongs_to :brother, :foreign_key => "primary_contact_id"
	has_many :attendances
	has_many :events, through: :attendances
	has_many :actions
	has_many :comments
	has_many :approvals

  # validates :email, uniqueness: true
  # validates :cellphone, uniqueness: true

  attr_accessor :primary_contact_brother

  def primary_contact_brother_email_must_exist
    errors.add(:primary_contact_brother, "No Brother has this email") if 
      !:primary_contact_brother.blank? and !Brother.find_by_email(:primary_contact_brother)
  end



end
