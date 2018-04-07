class User < ApplicationRecord
  has_secure_password

  validates :email, :username, :password, :name, :birthdate, presence: true, on: :create
  validates :email, :username, uniqueness: true

  before_save :format_downcase

  has_many :tokens, dependent: :destroy
  has_many :origins, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :commments, dependent: :destroy
  
  has_one :blocked_user, dependent: :destroy

  protected
  def format_downcase
    self.name.downcase!
    self.email.downcase!
    self.username.downcase!
  end
end
