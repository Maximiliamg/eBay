class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :product_id, :created_at, :updated_at

  belongs_to :user
end