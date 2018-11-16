class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = "422 Error"
    end
  end

  def new
    @user = User.new
    #render later
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  # def update
  #   user = User.find_by_credentials(params[:user][:email], params[:user][:password])
  #
  #   if user
  #     user.save!
  #   end
  # end
  #
  # def destroy
  #
  # end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
