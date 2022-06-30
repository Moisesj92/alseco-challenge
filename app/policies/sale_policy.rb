class SalePolicy < ApplicationPolicy

  #Solo puedo actualizar mis propias ventas
  
  class Scope
    attr_reader :current_user, :sales
    def initialize(current_user, sales)
      @current_user = current_user
      @sales = sales
    end

    def resolve
      sales.where(user: current_user.id)
    end
  end
end