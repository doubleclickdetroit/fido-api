class SubscriptionController < ApplicationController
  def subscription_checkout
    unless current_user.subscription
      @subscription = current_user.create_subscription(subscription_params)
      render json: @subscription and return
    end

    data = {
      error: 'subscription already exists for this user.'
    }
    render json: data, status: :unprocessable_entity
  end

  private
    def subscription_params
      params.require(:subscription).permit(:stripe_token)
    end
end
