class AddCurrentPeriodDatesToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :current_period_start, :date
    add_column :subscriptions, :current_period_end, :date
  end
end
