class Action < ActiveRecord::Base

	belongs_to 	:rushee
	has_many 	:action_brothers
	has_many	:brothers, through: :action_brothers

end
