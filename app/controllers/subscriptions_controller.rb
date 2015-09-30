class SubscriptionsController < ApplicationController
  before_action :set_subscription

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

  # GET /subscription
  # GET /subscription.json
  def show
    data = {
      subscriptions: [@subscription.details],
      credit_cards: @subscription.credit_cards
    }

    render json: data
  end

  # GET /subscription/credit_cards
  # GET /subscription/credit_cards.json
  def show_cards
    data = {
      credit_cards: @subscription.credit_cards
    }

    render json: data
  end

  # POST /subscription/credit_cards
  # POST /subscription/credit_cards.json
  def add_card
  end

  # GET /subscription/invoices
  # GET /subscription/invoices.json
  def show_invoices
    data = {
      invoices: @subscription.invoices
    }

    render json: data
  end

  private
    def set_subscription
      @subscription = current_user.subscription
    end

    def subscription_params
      params.require(:subscription).permit(:stripe_token)
    end
end
