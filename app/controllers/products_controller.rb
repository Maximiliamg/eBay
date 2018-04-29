class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  skip_before_action :get_current_user, only: [:index, :show]

  # GET /products
  def index
    products = Product.all
    render_ok products
  end

  # GET /products/1
  def show
    render_ok @product
  end

  # POST /products
  def create
    product = Product.new({user:@current_user}.merge product_params)
    was_saved = product.save 
    if was_saved
      trans = Transmission.new
      trans.create_pictures(params, product)
      if !trans.pictures.empty? or trans.empty_params
        render_ok product
      else render json: trans.errors, status: :unprocessable_entity end
    else render json: product.errors, status: :unprocessable_entity end
  end

  # PATCH/PUT /products/1
  def update
    if product_does_not_have_purchases?
      if @product.user_id == @current_user.id
        @product.update_attributes product_params 
        save_and_render @product
      else
        permissions_error
      end
    end
  end

  # DELETE /products/1
  def destroy
    if @product.user_id == @current_user.id
      render_ok @product.destroy
    elsif is_current_user_admin.nil?
      render_ok @product.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def product_does_not_have_purchases?
      if @product.purchases.empty? 
        true 
      else  
        render json: {authorization: 'You can not edit/destroy products that users already bought, we have to preserve the history'}, status: :unprocessable_entity
      end
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.permit(
        :name,
        :description,
        :category,
        :shipping_description,
        :origin_id,
        :stock,
        :price,
        :is_used,
        :is_auction)
    end
end
