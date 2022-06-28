class Product < ApplicationRecord
  belongs_to :user
  has_many :product_sale
  has_many :sales, through: :product_sale

  enum status: { draft: 0, published: 1 }
  enum user_roles: User.roles

  validates :sku, presence: true, uniqueness: true

  scope :join_user, -> {joins(:user)}
  scope :only_supplier_products, -> { join_user.where(user: {role: :supplier}) }
  scope :only_retailer_products, -> { join_user.where(user: {role: :retailer}) }
end
