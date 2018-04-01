class Cart < ApplicationRecord

	validates :quantity, :buyer_score, :seller_score, presence: true, on: :create

	belongs_to :purchase
	has_many :products

end
