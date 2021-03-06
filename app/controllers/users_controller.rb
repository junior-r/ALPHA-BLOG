class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@pagy, @articles = pagy(@user.articles.all, items: 4)
	end

	def index
		@pagy, @users = pagy(User.all, items: 4)
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "Your account information was succesfully updated"
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
			redirect_to articles_path
		else 
			render 'new'
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end