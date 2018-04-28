class OriginsController < ApplicationController
  before_action :set_origin, only: [:show, :update, :destroy]

  # GET /origins
  def index
    render_ok @current_user.origins
  end

  # GET /origins/1
  def show
    render_ok @origin
  end

  # POST /origins
  def create
    origin = Origin.new({user:@current_user}.merge origin_params)
    save_and_render origin
  end

  # PATCH/PUT /origins/1
  def update
    if is_my_origin? and is_not_a_purchase_associated?
      @origin.update_attributes origin_params
      save_and_render @origin
    end
  end

  # DELETE /origins/1
  def destroy
    render_ok @origin.destroy if is_my_origin? and is_not_a_product_associated?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_origin
      @origin = Origin.find(params[:id])
    end

    def is_my_origin?
      if @origin.user.id == @current_user.id then true else permissions_error end
    end

    def is_not_a_product_associated?
      if Product.Where(origin:@origin).empty?
        true
      else
        render json: {authorization: 'You can not edit/destroy origin with products associated'}, status: :unprocessable_entity
      end
    end 

    def is_not_a_purchase_associated?
      render = false
      Product.where(origin:@origin).map { |product| if !product.purchases.empty? then render = true ; break end }
      if !render
        true 
      else  
        render json: {authorization: 'You can not edit/destroy products that users already bought, we have to preserve the history'}, status: :unprocessable_entity
      end
    end

    # Only allow a trusted parameter "white list" through.
    def origin_params
      params.permit(:country, :state, :city, :postal_code, :address, :description)
    end
end
