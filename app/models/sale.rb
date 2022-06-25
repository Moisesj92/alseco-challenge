class Sale < ApplicationRecord
  belongs_to :user
  has_many :product_sale
  has_many :products, through: :product_sale

  enum status: { initiated: 0, paid: 1, rejected_payment: 2, routed: 3, complete: 4, canceled: 5 }

  validate :opened_sale, on: :create

  def opened_sale
    errors.add('already have a sale open') unless user.sales.where(status: :initiated).empty?
  end

end
