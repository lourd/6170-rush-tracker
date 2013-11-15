class RusheesController < ApplicationController

	before_filter :authenticate_brother!

	def index
    	@rushees = current_brother.fraternity.rushees
	end

	def new
		@rushee = Rushee.new
	end

	def edit
	end

	def delete
	end
end
