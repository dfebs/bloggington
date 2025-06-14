class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  before_action :set_user, only: %i[show]
  before_action :verify_user, only: %i[edit update]
  def new
    if authenticated?
      redirect_back fallback_location: root_path, alert: "You can't register if you're already logged in!"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "User created!"
    else
      redirect_to new_user_path, alert: "User failed to be created!"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user), status: :unprocessable_entity, alert: "Unable to update user"
    end
  end

  private
  def user_params
    params.expect user: [ :username, :email_address, :password, :password_confirmation, :profile_picture ]
  end

  def set_user
    @user = User.find(params[:id])
  end

  def verify_user
    Rails.logger.debug "Current.session BEFORE: #{Current.session.inspect}"
    set_user
    Rails.logger.debug "Current.session AFTER: #{Current.session.inspect}"
    if Current.user != @user
      redirect_to root_path, alert: "NO, BAD. You can't edit other user data"
    end
  end
end
