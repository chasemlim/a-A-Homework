class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:notice] = "Incorrect Credentials!"
      render :new
    end
  end

  def new
    if logged_in?
      return redirect_to user_url(current_user)
    end

    @user = User.new
    render :new
  end

  def destroy
    log_out_user!
    redirect_to new_session_url
  end

end
