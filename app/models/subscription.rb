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

  def credit_cards
    customer = Stripe::Customer.retrieve( customer_id )
    cards = customer.sources.all(limit: 3, object: 'card')
    cards.data.map do |card|
      {
        id: card.id,
        brand: card.brand,
        last4: card.last4,
        exp_month: card.exp_month,
        exp_year: card.exp_year
      }
    end
  end

  def details
    subscription = get_stripe_subscription
    price        = subscription.plan.amount * user.occasions.count #until quantity gets updated from PUT
    current_period_start = Time.at(subscription.current_period_start).to_date
    current_period_end   = Time.at(subscription.current_period_end).to_date

    {
      id: id,
      price: price,
      current_period_start: current_period_start,
      current_period_end: current_period_end
    }
  end

  def invoices
    invoices = Stripe::Invoice.all( limit: 5, customer: customer_id )
    invoices.map do |invoice|
      {
        id: invoice.id,
        date: Time.at(invoice.date).to_date,
        total: invoice.total
      }
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
      self.current_period_start = Time.at(subscription.current_period_start)
      self.current_period_end = Time.at(subscription.current_period_end)
    end

    def get_stripe_subscription
      customer = Stripe::Customer.retrieve(customer_id)
      subscription = customer.subscriptions.retrieve(subscription_id)
    end

    def update_stripe_subscription
      subscription = get_stripe_subscription
      subscription.quantity = products.count
      subscription.save
    end
end
