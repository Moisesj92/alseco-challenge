class Product < ApplicationRecord
  belongs_to :user
  has_many :product_sale
  has_many :sales, through: :product_sale

  enum status: { draft: 0, published: 1 }

end
