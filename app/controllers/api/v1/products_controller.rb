class Api::V1::ProductsController < ApplicationController
  # respond_to :json

  def index
    @products = Product.all
    render json: @products
  end

  def create
    product = Product.new(product_params)
    respond_to do |format|
       format.json do
           if product.save
              render json: product, status: :created, location: product
           else
              render json: product.errors, status: :unprocessable_entity
           end
       end
     end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: product, status: :ok, location: product
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    head :no_content
  end

  private
    def product_params
      params.require(:product).permit(:name, :price)
    end
end
