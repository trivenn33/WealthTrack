class Holding < ApplicationRecord
  belongs_to :portfolio
  validates :symbol, :quantity, :average_price, presence: true
end
