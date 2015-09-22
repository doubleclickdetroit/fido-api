if Rails.env == 'production'
  Rails.configuration.stripe = {
    :publishable_key => CONFIG[:stripe_publishable_key],
    :secret_key      => CONFIG[:stripe_secret_key]
  }
else
  Rails.configuration.stripe = {
    :publishable_key => CONFIG[:stripe_publishable_key],
    :secret_key      => CONFIG[:stripe_secret_key]
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
