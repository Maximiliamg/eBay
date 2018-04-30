class BidSerializer < ActiveModel::Serializer
  attributes :id, :bid, :created_at, :updated_at, :user

  has_one :user

  belongs_to :product

  def user  
    UserSerializer.new(object.user, root: false)
  end
  
end