class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = current_user.contacts

    render json: @contacts
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    render json: { contact: @contact, occasions: @contact.occasions }
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = current_user.contacts.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    if @contact.update(contact_params)
      head :no_content
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy

    head :no_content
  end

  private

    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :gender, :relationship)
    end
end
