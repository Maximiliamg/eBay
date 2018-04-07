class BidsController < ApplicationController
  before_action :set_bid, only: [:show]
  before_action :set_product, only: [:index, :create]
  skip_before_action :get_current_user, only: [:index, :show]

  # GET /bids
  def index
    render_ok @product.bids
  end

  def index_user
    render_ok @current_user.bids
  end

  # GET /bids/1
  def show
    render_ok @bid
  end

  # POST /bids
  def create
    proceed = false
    if @product.is_auction
      if !@product.bids.empty? then if Bid.last.price < params[:bid] then proceed = true end
      elsif params[:bid] > @product.price then proceed = true end
      if proceed then save_and_render Bid.new(user_id:@current_user.id, product_id:params[:product_id], bid:params[:bid])
      else render json: {authorization: 'Bid too low'}, status: :unprocessable_entity end
    else render json: {authorization: 'The product is not auction'}, status: :unprocessable_entity end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bid
    @bid = Bid.find params[:id]
  end

  def set_product
    @product = Product.find params[:product_id]
  end
end
