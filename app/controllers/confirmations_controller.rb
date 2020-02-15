class ConfirmationsController < Devise::ConfirmationsController
  # private
  def show 
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      redirect_to home_account_verification_path
    end
  end
  
end