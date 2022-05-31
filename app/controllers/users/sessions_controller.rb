class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super
  end
  private

  def respond_with(resource, _opts = {})
    
    respond_to do |format|
      format.json { render json: { message: 'You are logged in.' }, status: :ok }
      format.html
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    logout_out_failure
  end

  def log_out_success
    respond_to do |format|
      format.json { render json: { message: 'You are logged out.' }, status: :ok }
      format.html
    end
  end

  def logout_out_failure
    respond_to do |format|
      format.json { render json: {message: 'Failure to logout'}, status: :unauthorized }
      format.html
    end
  end
end