class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show edit update destroy ]

  def show
    @products = @sale.products
  end

  def create
    product = Product.find(params[:product_id])
    @sale = Sale.new()
    @sale.user = current_user
    @sale.amount = product.price
    @sale.products << [product]

    respond_to do |format|
      if @sale.save
        format.html { redirect_to products_path, notice: "Product was successfully added to cart." }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { redirect_to products_path, notice: "already have open sale" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    product = Product.find(params[:product_id])
    if params[:update_action] == "add"
      @sale.amount = @sale.amount + product.price
      @sale.products << [product]
    elsif params[:update_action] == "remove"
      @sale.products.delete product
      @sale.reload
      @sale.amount = @sale.products.sum(&:price)
    end

    respond_to do |format|
      if @sale.save
        if params[:update_action] == "remove"
          format.html { redirect_to sale_url(@sale), notice: "cart was successfully updated." }
        else
          format.html { redirect_to products_path, notice: "cart was successfully updated." }
        end
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { redirect_to products_path, notice: "cart update error" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @sale.products.destroy_all
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params[:id])
  end

end