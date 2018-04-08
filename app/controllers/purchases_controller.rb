class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :set_buyer_score, :set_seller_score, :set_was_shipped, :set_was_delivered]
  before_action :set_product, only: [:create]

  # GET /purchases
  def index
    render_ok @current_user.bought_products
  end

  def index_sales
    render_ok @current_user.sold_products
  end

  # GET /purchases/1
  def show
    render_ok @purchase
  end

  def set_buyer_score
    if 0 < params[:buyer_score] and 6 > params[:buyer_score]
      @purchase.update_attribute(:buyer_score, params[:buyer_score])
      save_and_render @purchase
    else
      render json: {authorization: 'enter a value between 1 and 5'}, status: :unprocessable_entity
    end
    
  end

  def set_seller_score
    if 0 < params[:seller_score] and 6 > params[:seller_score]
      @purchase.update_attribute(:seller_score, params[:seller_score])
      save_and_render @purchase
    else
      render json: {authorization: 'enter a value between 1 and 5'}, status: :unprocessable_entity
    end
  end

  def set_was_shipped
    @purchase.update_attribute(:was_shipped, params[true])
    save_and_render @purchase
  end

  def set_was_delivered
    @purchase.update_attribute(:was_delivered, params[true])
    save_and_render @purchase
  end

  # POST /purchases
  def create
    purchase = Purchase.new(buyer_id:@current_user.id, seller_id:@product.user.id, quantity:params[:quantity])
    save_and_render purchase
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def purchase_params
      params.permit(
        :buyer_id,
        :seller_id,
        :quantity,
        )
    end

    def set_product
    @product = Product.find params[:product_id]
    end
end
