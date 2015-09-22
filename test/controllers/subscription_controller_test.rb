require 'test_helper'

class SubscriptionControllerTest < ActionController::TestCase
  test "should get subscription_checkout" do
    get :subscription_checkout
    assert_response :success
  end

end
