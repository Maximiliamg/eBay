class Product < ApplicationRecord

  validates :name, :category, :shipping_description, :stock, :price, presence: true, on: :create

  before_save :format_downcase

  belongs_to :user
  has_one :origin
  has_many :comments, dependent: :destroy
  has_many :bids, dependent: :destroy

  protected
    def format_downcase
    self.name.downcase!
    self.shipping_description.downcase!
    self.description.downcase!
  end
end
