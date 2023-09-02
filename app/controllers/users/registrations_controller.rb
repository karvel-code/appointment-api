# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?
  include RackSessionFix
  respond_to :json

  protected

  def configure_permitted_parameters    
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[type first_name last_name])
  end

  private

  def respond_with(resource, _opts = {})
# Successfull sign up
    if request.method == "POST" && resource.persisted?
      render json: {
        status: {code: 200, message: "Signed up sucessfully."},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
# Successfull sign out      
    elsif request.method == "DELETE"
      render json: {
        status: { code: 200, message: "Account deleted successfully."}
      }, status: :ok
# Unsuccessfull sign up      
    else
      render json: {
        status: {code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

end
