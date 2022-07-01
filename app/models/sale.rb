class Sale < ApplicationRecord
  belongs_to :user
  has_many :product_sale
  has_many :products, through: :product_sale

  enum status: { initiated: 0, paid: 1, rejected_payment: 2, routed: 3, complete: 4, canceled: 5 }

  validate :opened_sale, on: :create
  #TODO cant buy owner products
  #TODO cant buy products with 0 stock

  before_save :calculate_amount

  scope :created_between, lambda { |start_date, end_date| where(created_at: start_date..end_date) }

  def opened_sale
    errors.add(:sale, 'already have a sale open') unless user.sales.where(status: :initiated).empty?
  end

  def calculate_amount
    return amount = 0 unless products.present?
    amount = products.sum(&:price)
  end

end
