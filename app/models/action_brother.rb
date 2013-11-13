class ActionBrother < ActiveRecord::Base

	belongs_to	:brother
	belongs_to	:action

	validates	:action, presence: true
	validates	:brother, presence: true, :uniqueness => { :scope => :action}

end
