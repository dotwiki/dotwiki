class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password], params[:remember])
    if @user
      redirect_to(root_path, notice: t('.notice'))
    else
      flash.now[:alert] = t('.flash_alert')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: t('.notice'))
  end
end