class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |user|
      data = {
        email: user.email,
        token: user.authentication_token,
        is_activated: user.subscription.present?
      }

      render json: data, status: 201 and return
    end
  end

  def show
    render json: current_user
  end
end
