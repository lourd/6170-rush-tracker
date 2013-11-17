class Rushee < ActiveRecord::Base

	belongs_to :fraternity
	belongs_to :brother, :foreign_key => "primary_contact_id"
	has_many :attendances
	has_many :events, through: :attendances
	has_many :actions
	has_many :comments
	has_many :approvals

	# attr_accessible :picture

  def self.findAllByPrimaryContactID id
    self.where :primary_contact_id => id
  end

  # Associates the :picture attribute with an attached file
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

end
