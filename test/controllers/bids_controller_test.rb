require 'test_helper'

class BidsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bid = bids(:one)
  end

  test "should get index" do
    get bids_url, as: :json
    assert_response :success
  end

  test "should create bid" do
    assert_difference('Bid.count') do
      post bids_url, params: { bid: { bid: @bid.bid, product_id: @bid.product_id, user_id: @bid.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show bid" do
    get bid_url(@bid), as: :json
    assert_response :success
  end

  test "should update bid" do
    patch bid_url(@bid), params: { bid: { bid: @bid.bid, product_id: @bid.product_id, user_id: @bid.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy bid" do
    assert_difference('Bid.count', -1) do
      delete bid_url(@bid), as: :json
    end

    assert_response 204
  end
end
