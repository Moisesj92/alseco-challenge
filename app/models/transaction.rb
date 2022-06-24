class Transaction < ApplicationRecord
  belongs_to :user
  has_many :product_transactions
  has_many :products, through: :product_transactions


  enum status: { initiated: 0, paid: 1, rejected_payment: 2, routed: 3, complete: 4, canceled: 5 }

end
