class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def show_by_name
		@user = User.find_by_name(params[:name])
		render 'show'
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Welcome to Sample App"
			redirect_to root_path
		else
			render 'new'
		end
	end
end
