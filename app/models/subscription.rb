class Subscription < ActiveRecord::Base
  belongs_to :user

  before_create :set_initial_quantity

  private
    def set_initial_quantity
      products = user.occasions
      self.quantity = products.count
    end
end
