class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)

        data = {
          id: resource.id,
          token: resource.authentication_token,
          email: resource.email
        }
        render json: data, status: 201 and return
      else
        expire_data_after_sign_in!

        data = {
          error: "Invalid login credentials"
        }
        render json: data, status: 401 and return
      end
    else
      clean_up_passwords resource
      set_minimum_password_length

      data = {
        error: "Credentials are already taken"
      }
      render json: data, status: 401 and return
    end
  end

  protected

    def set_minimum_password_length
      if devise_mapping.validatable?
        @minimum_password_length = resource_class.password_length.min
      end
    end
end
