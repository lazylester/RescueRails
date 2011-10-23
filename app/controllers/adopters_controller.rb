class AdoptersController < ApplicationController

	def new
		@adopter = Adopter.new
		@adopter.adoption_app.build
	end

	def create
		@adopter = Adopter.new(params[:adopter])
		@adopter.status = 'pending'
		if @adopter.save
			flash[:success] = "Adopter Created"
			redirect_to root_path
		else
			render 'new'
		end

	end
end