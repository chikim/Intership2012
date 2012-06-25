class SessionsController < ApplicationController

	def new
	end
	
	def create
		# using when view uses form_for
		#user = User.find_by_email(params[:session][:email])
		#if user && user.authenticate(params[:section][:password])
		
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end
	
	def destroy
		sign_out
		redirect_to root_path
	end
end
