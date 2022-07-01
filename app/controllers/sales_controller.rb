class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show update destroy add_products remove_products ]

  # GET /sales
  def index
    @sales = policy_scope(Sale)

    render json: @sales, include: [:products] 
  end

  # GET /sales/1
  def show
    render json: @sale, include: [:products] 
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params.except(:products))
    @sale.user = current_user

    if sale_params[:products]
      sale_params[:products].each do |product|
        current_product = Product.find(product[:id])
        @sale.products << current_product
      end
    end

    @sale.amount = @sale.calculate_amount

    if @sale.save
      render json: @sale, status: :created, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(update_sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.product_sale.destroy_all
    @sale.destroy
  end

  def add_products
    sale_params[:products].each do |product|
      current_product = Product.find(product[:id])
      @sale.products << current_product
    end

    @sale.amount = @sale.calculate_amount

    if @sale.save
      render json: @sale, include: [:products], status: :ok, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end

  end

  def remove_products
    sale_params[:products].each do |product|
      current_product = Product.find(product[:id])
      @sale.products.delete current_product
    end

    @sale.amount = @sale.calculate_amount

    if @sale.save
      render json: @sale, include: [:products], status: :ok, location: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  def by_user
    sales = User.find(params[:user_id]).sales.where(status: 4).created_between(params[:start_date], params[:end_date])
    total = sales.sum(&:amount)
    response = { sales: sales, total_amount: total }

    render json: response, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:amount, :status, products: product_params)
    end

    def update_sale_params
      params.require(:sale).permit(:status)
    end

    def product_params
      [:id]
    end

end
