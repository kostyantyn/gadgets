class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = current_user.products.search(params).includes(:pictures).page(params[:page]).per(20)
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = current_user.products.build
    respond_with(@product)
  end

  def create
    @product = current_user.products.create(product_params)
    respond_with(@product)
  end

  def edit
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private
    def find_product
      @product = current_user.products.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, pictures_attributes: [:id, :image, :_destroy])
    end

end
