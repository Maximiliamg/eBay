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
    product = Product.new(product_params)
    save_and_render product
  end

  # PATCH/PUT /products/1
  def update
    if @product.user_id == @current_user.user_id
      @product.update_attributes product_params
      save_and_render @product
    else
      permissions_error
    end
  end

  # DELETE /products/1
  def destroy
    if @product.user_id == @current_user.user_id
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
        :is_used)
    end
end
