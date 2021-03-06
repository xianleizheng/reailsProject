class UsersController < ApplicationController
  before_action :correct_user,only: [:edit, :update]
  before_action :admin_user,only: :destroy
  before_action :signed_in_user,only: [:index, :edit, :update, :destroy, :following, :followers]
	def upload_file #上传文件
		email=params[:email]
		file=params[:file][:file]
		delete_picture(email,file)
		picture_upload($FILENAME,email)
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		puts "#{Rails.root}"
		puts params[:file][:file]
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		puts "+++++++++++++++++++++++++++++++++++"
		flash[:success] = "shibai！"
		 redirect_to root_path
	end
  def index
  	@users = User.paginate(page: params[:page])
  end
  def new
  	@user = User.new
  end

  def edit
   	
   end

   def destroy
   	User.find(params[:id]).destroy
	flash[:success] = "User destroyed."
	redirect_to users_url
  end

  def show
  	@user = User.find(params[:id])
  	@microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
	@user = User.new(user_params)
	# Not the final implementation!
	if @user.save
		# Handle a successful save.
		sign_in @user
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	else
		render 'edit'
	end
  end

  def update
	if @user.update_attributes(user_params)
		flash[:success] = "Profile updated"
		sign_in @user
		redirect_to @user
	else
		render 'edit'
	end
  end

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end
	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

  #private
  	def user_params
		params.require(:user).permit(:name, :email, :password,:password_confirmation)
	end

	def admin_user
		redirect_to(root_path) unless current_user.admin?
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end
end
