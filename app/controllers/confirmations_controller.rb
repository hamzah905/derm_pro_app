class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    # sign_in(resource) # In case you want to sign in the user
    redirect_to home_account_verification_path
    return
  end
end