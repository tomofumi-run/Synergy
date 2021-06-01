class Public::ContactsController < ApplicationController
  
  def new
    @contact = Contact.new  
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
      redirect_to thanx_contact_path, notice:"お問合せありがとうございました。"
    else
      render :new
    end
  end
  
  def thanx
  end
  
  private
    
    def contact_params
      params.require(:contact).permit(:name,:email,:subject,:message)
    end
end
