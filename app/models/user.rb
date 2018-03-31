class User < ApplicationRecord
  has_secure_password

  validates :email, :username, :password, :name, presence: true, on: :create
  validates :email, :username, unique: true

  before_save :format_downcase

  has_many :tokens, :origins, :products dependent: :destroy
  has_many :comments

  protected
  def format_downcase
    self.name.downcase!
    self.email.downcase!
    self.username.downcase!
  end
end
