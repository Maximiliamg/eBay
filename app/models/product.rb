class Product < ApplicationRecord

  validates :name, :category, :shipping_description, :price, :origin_id, presence: true, on: :create

  before_save :format_downcase

  belongs_to :cover, optional: true, class_name: Picture, foreign_key: :picture_id, dependent: :destroy
  belongs_to :origin
  belongs_to :user

  has_many :commments, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :purchases
  has_many :product_picture, dependent: :destroy

  protected
    def format_downcase
    self.name.downcase!
    self.shipping_description.downcase!
  end
end
