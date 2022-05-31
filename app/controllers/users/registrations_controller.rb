class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    respond_to do |format|
      format.json { render json: { message: 'Signed up successfully.' } }
      format.html
    end
    
  end

  def register_failed
    respond_to do |format|
      format.json { render json: { message: "Failed to register, #{resource.errors.full_messages.join(', ')}" } }
      format.html
    end
  end
end
