  class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@user = current_user
    @topics = @user.topics.paginate(page: params[:page], :per_page =>10)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		#handle a successfull save.
      sign_in @user
  		flash[:success] = "Welcome to CSPortal!"
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name,:email,:password, :education_level, :password_confirmation)
  	end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
