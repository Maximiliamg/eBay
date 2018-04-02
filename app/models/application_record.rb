class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  enum role: [:normal , :admin]
  enum gender: [:other, :female, :male]
end
