class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  validates :customer_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

end
