class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:create, :show]

  # GET /subscription
  # GET /subscription.json
  def show
    render json: @subscription
  end

  # POST /subscription
  # POST /subscription.json
  def create
    unless @subscription
      subscription = current_user.create_subscription(subscription_params)
      render json: subscription and return
    end

    data = {
      error: 'subscription already exists for this user.'
    }
    render json: data, status: :unprocessable_entity
  end

  private
    def set_subscription
      @subscription = current_user.subscription
    end

    def subscription_params
      params.require(:subscription).permit(:stripe_token)
    end
end
