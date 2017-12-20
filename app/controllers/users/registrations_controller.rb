class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :select_plan, only: :new
  
  before_filter :configure_permitted_parameters
  
  respond_to :json

  # POST /resource
   def create    
    build_resource(sign_up_params)

    yield resource if block_given?
    if resource.save
      sign_up(resource_name, resource)
      return render :json => {:success => true}
    else
      clean_up_passwords resource
      #passing block to handle error in signup for json
      #http://edgeapi.rubyonrails.org/classes/ActionController/Responder.html
      render :json => { :messages => resource.errors.full_messages.join(". ") }, :status => 422
    end
   end
    
  def after_sign_up_path_for(resource)
    root_path
  end
    
  def create_old  
    # super do |resource|
    #   if params[:plan]
    #     resource.plan_id = params[:plan]
    #     if resource.plan_id == 2
    #       resource.save_with_subscription
    #     else
    #       resource.save
    #     end
    #   end
    # end
    # build_resource
 
    # if resource.save
    #   if resource.active_for_authentication?
    #     set_flash_message :notice, :signed_up if is_navigational_format?
    #     sign_up(resource_name, resource)
    #     return render :json => {:success => true}
    #   else
    #     set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
    #     expire_session_data_after_sign_in!
    #     return render :json => {:success => true}
    #   end
    # else
    #   clean_up_passwords resource
    #   return render :json => {:success => false}
    # end
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name]) #, :stripe_card_token
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :current_password])
  end
  
  private
  
    def select_plan
      unless (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
end