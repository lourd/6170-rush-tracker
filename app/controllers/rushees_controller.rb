class RusheesController < ApplicationController

	def index
    	@rushees = current_brother.fraternity.rushees
	end

	def new
	end

	def edit
	end

	def delete
	end
end
