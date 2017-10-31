class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged In!"
    else
      render :new
    end
  end
  def show
    @user = User.find params[:id]
  end

  # def edit
  #   @user = current_user #User.find params[:id]
  # end
  #
  # def update
  #   @user = current_user
  #   return head :unauthorized unless can?(:update, @user)
  #   # @post = Post.find params[:id]
  #   if @user.update user_params
  #     redirect_to root_path
  #   else
  #     render :edit
  #   end
  # end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
    )
  end

end
