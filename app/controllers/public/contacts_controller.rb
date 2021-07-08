class Public::ContactsController < ApplicationController
  before_action :authenticate_user!  
  before_action :ensure_normal_user, only:  %i(new create)
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      # deliverでcontact_mailを送信する
      ContactMailer.contact_mail(@contact).deliver
      redirect_to thanx_contacts_path, notice: 'お問合せありがとうございました。'
    else
      flash.now[:alert] = '未入力の箇所があります。'
      render :new
    end
  end

  def thanx; end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
end
