class Purchase < ApplicationRecord
	validates :buyer_score, :seller_score, presence: true, on: :create

	belongs_to :seller, :class_name => 'User'
  	belongs_to :buyer, :class_name => 'User'
  	belongs_to :destiny, :class_name => 'Origin'

  	belongs_to :destiny, optional: true, :class_name => 'Origin'
end
