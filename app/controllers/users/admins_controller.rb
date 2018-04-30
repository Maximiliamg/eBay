class Users::AdminsController < ApplicationController 
  before_action :is_current_user_admin
  before_action :set_user, only: [:block]
  before_action :set_product, only: [:block_product]
  
  def block
    if !@user.tokens.nil?
      @user.tokens.map do |token| #.map is required to iterate through ActiveRecord::Associations::CollectionProxy element, it is not an array...
        token.destroy
      end
    end
    block = BlockedUser.new(user_id:params[:user_id].to_i)
    save_and_render block
  end

  def block_product
    block_product = BlockedProduct.new(product_id:params[:product_id].to_i, blocked_quantity:@product.stock)
    @product.update_attribute(:stock, 0)
    save_and_render block_product
  end

  def unblock
    block = BlockedUser.where(user_id:params[:user_id].to_i).first
    if block
      render_ok block.destroy
    else
      render json: {authorization: 'user is not blocked'}, status: :unprocessable_entity
    end  
  end

  def unblock_product
    block_product = BlockedProduct.where(product_id:params[:product_id].to_i).first
    if block_product
      render_ok block_product.destroy
    else
      render json: {authorization: 'product is not blocked'}, status: :unprocessable_entity
    end  
  end

  def index_block
    render_ok BlockedUser.all
  end

  def index_block_products
    render_ok BlockedProduct.all
  end

  private 
  def set_user
    @user = User.find params[:user_id]
  end

  def set_product
    @product = Product.find params[:product_id]
  end
end