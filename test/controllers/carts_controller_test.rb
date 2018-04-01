require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get carts_url, as: :json
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: { buyer_score: @cart.buyer_score, product_id: @cart.product_id, purchase_id: @cart.purchase_id, quantity: @cart.quantity, seller_score: @cart.seller_score } }, as: :json
    end

    assert_response 201
  end

  test "should show cart" do
    get cart_url(@cart), as: :json
    assert_response :success
  end

  test "should update cart" do
    patch cart_url(@cart), params: { cart: { buyer_score: @cart.buyer_score, product_id: @cart.product_id, purchase_id: @cart.purchase_id, quantity: @cart.quantity, seller_score: @cart.seller_score } }, as: :json
    assert_response 200
  end

  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
      delete cart_url(@cart), as: :json
    end

    assert_response 204
  end
end
