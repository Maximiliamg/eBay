class Bid < ApplicationRecord

	validates :bid, presence: true, on: :create

	belongs_to :user, :product
end
