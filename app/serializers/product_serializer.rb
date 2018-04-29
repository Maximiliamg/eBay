class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :category, :shipping_description, :stock, :price, :is_used, :is_auction, :created_at, :updated_at

  belongs_to :user
  belongs_to :cover
  belongs_to :origin
  has_many :bids 
  has_many :product_picture
end