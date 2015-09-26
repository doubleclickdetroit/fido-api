class Subscription < ActiveRecord::Base
  belongs_to :user

  before_create :set_quantity, :create_stripe_customer
  after_update :update_stripe_subscription

  def products
    if current_period_start && current_period_end
      start_date = Time.at(current_period_start).to_date
      end_date = Time.at(current_period_end).to_date

      user.occasions.current(start_date, end_date)
    else
      user.occasions
    end
  end

  private
    def set_quantity
      self.quantity = products.count
    end

    def create_stripe_customer
      customer = Stripe::Customer.create(
        description: 'Customer for Fido',
        source: stripe_token,
        email: user.email
      )
      self.customer_id = customer.id

      subscription = customer.subscriptions.create(
        plan: 'card',
        quantity: quantity
      )
      self.subscription_id = subscription.id
      self.current_period_start = subscription.current_period_start
      self.current_period_end = subscription.current_period_end
    end

    def update_stripe_subscription
      customer = Stripe::Customer.retrieve(stripe_token)
      subscription = customer.subscriptions.retrieve(subscription_id)
      subscription.quantity = products.count
      subscription.save
    end
end
