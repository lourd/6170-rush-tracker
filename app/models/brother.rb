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
end
