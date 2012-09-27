require 'test_helper'

class ShippingAddressesControllerTest < ActionController::TestCase
  setup do
    @subscriber = subscribers(:tsai)
    @shipping_address = shipping_addresses(:tangzi)
    session[:subscriber_id] = @subscriber.id
    load "#{Rails.root}/db/seeds.rb"
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipping_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipping_address" do
    assert_difference('ShippingAddress.count') do
      post :create, :shipping_address => { :receiver => "tsai", :address => "Room 305 No. 24 Tangzi Street" }, :district => 191011
    end

    assert_redirected_to shipping_address_path(assigns(:shipping_address))
  end

  test "should show shipping_address" do
    get :show, id: @shipping_address
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipping_address
    assert_response :success
  end

  test "should update shipping_address" do
    put :update, id: @shipping_address, :shipping_address => { :receiver => "tsai", :address => "Room 502 No. 24 Tangzi Street" }, :district => 191011
    assert_redirected_to shipping_address_path(assigns(:shipping_address))
  end

  test "should destroy shipping_address" do
    assert_difference('ShippingAddress.count', -1) do
      delete :destroy, id: @shipping_address
    end

    assert_redirected_to shipping_addresses_path
  end
end
