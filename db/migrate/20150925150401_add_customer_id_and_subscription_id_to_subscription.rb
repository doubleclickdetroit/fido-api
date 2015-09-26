class AddCustomerIdAndSubscriptionIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :customer_id, :string
    add_column :subscriptions, :subscription_id, :string
  end
end
