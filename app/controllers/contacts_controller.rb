class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_admin_user, only: :index
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    @contact.email = current_user.email
    respond_to do |format|
      if @contact.save
        format.html { redirect_to root_path }
        format.js
      else
        format.html { redirect_to root_path }
      end
    end
  end
  
  def index
    @contacts = Contact.all
  end
  
  private
  def contact_params
    params.require(:contact).permit(:email, :comments)
  end
  
  def only_admin_user
    @user = current_user
    redirect_to(root_url) unless @user.email == "nathan_saunders@hotmail.co.uk"
  end
end