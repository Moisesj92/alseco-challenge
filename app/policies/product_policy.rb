class ProductPolicy < ApplicationPolicy
  class Scope
    attr_reader :current_user, :products
    def initialize(current_user, products)
      @current_user = current_user
      @products = products
    end

    def resolve
      if current_user.role == "supplier"
        products.only_retailer_products.published.where.not(user: current_user.id)
      elsif current_user.role == "retailer"
        products.only_supplier_products.published.where.not(user: current_user.id)
      elsif current_user.role == "client"
        products.only_retailer_products.published
      end
    end

  end
end