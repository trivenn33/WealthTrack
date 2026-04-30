class Portfolio < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :holdings, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
