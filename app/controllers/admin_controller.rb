class AdminController < ApplicationController
  before_filter :authenticate_user!
  requires_permission :admin

  # TODO : multiple guild support

  # Users management starting page
  def index
    @users = User.all
  end

  def edit_user
    @user = User.find(params[:id])

    if request.post?
      @user.update_attribute(:role, params[:user][:role])
      redirect_to admin_path
    end
  end

  # Raids history page
  def raids
  end

  # Log / Events page
  def logs
  end

  # API information page
  def api
    @guild = current_guild

    if @guild.api_key.nil?
      @guild.generate_api_key!
    end
  end

end