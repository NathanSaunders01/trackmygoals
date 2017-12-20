class Users::SessionsController < Devise::SessionsController  

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource
  
    if resource.valid_password?(params[:user][:password])
      sign_in :user, resource
      return render nothing: true
    end
  
    invalid_login_attempt
  end
  
  protected  
  
  def invalid_login_attempt
    render json: { :messages => "Invalid username or password." }, status: 422
  end
end