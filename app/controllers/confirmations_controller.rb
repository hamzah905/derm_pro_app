class ConfirmationsController < Devise::ConfirmationsController
  
  protected
  def do_confirm
    # sign_in(resource) # In case you want to sign in the user
    redirect_to home_account_verification_path
  end
end