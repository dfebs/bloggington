class EmailAddressVerificationsController < ApplicationController
  def show
    @user = User.find_by_email_address_verification_token(params[:token])

    if @user == Current.user
      @user.verify
      # Handle valid case: render a JSON payload or redirect to another page
    else
      # Handle invalid case: render a JSON payload or redirect to another page
    end
  end

  def resend
    UserMailer.verify_email_address(Current.user).deliver_later
    # Handle response: render a JSON payload or redirect to another page
  end
end
