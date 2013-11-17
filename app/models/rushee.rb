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

  attr_accessor :primary_contact_brother


  def self.findAllByPrimaryContactID id
    self.where :primary_contact_id => id
  end

end
