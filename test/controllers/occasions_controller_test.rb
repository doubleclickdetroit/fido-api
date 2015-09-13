require 'test_helper'

class OccasionsControllerTest < ActionController::TestCase
  setup do
    @occasion = occasions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:occasions)
  end

  test "should create occasion" do
    assert_difference('Occasion.count') do
      post :create, occasion: { contact_id: @occasion.contact_id, date: @occasion.date, label: @occasion.label }
    end

    assert_response 201
  end

  test "should show occasion" do
    get :show, id: @occasion
    assert_response :success
  end

  test "should update occasion" do
    put :update, id: @occasion, occasion: { contact_id: @occasion.contact_id, date: @occasion.date, label: @occasion.label }
    assert_response 204
  end

  test "should destroy occasion" do
    assert_difference('Occasion.count', -1) do
      delete :destroy, id: @occasion
    end

    assert_response 204
  end
end
