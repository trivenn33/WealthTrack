class Transaction < ApplicationRecord
  belongs_to :portfolio

  validates :symbol, :transaction_type, :quantity, :price, presence: true
  validates :transaction_type, inclusion: { in: %w[buy sell] }
end