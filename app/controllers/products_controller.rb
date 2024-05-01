class ProductsController < ApplicationController
    include ApplicationHelper
    skip_before_action :verify_authenticity_token, only: [:create, :update]
    def create
      @product = Product.new(product_params)
      if @product.save
        # Notify third-party APIs of the new product
        notify_third_parties('Product', "Product created: #{@product}")
        render json: @product, status: :created
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        # Notify third-party APIs of the updated product
        notify_third_parties('Product', "Product updated: #{@product}")
        render json: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
    private

    def product_params
      params.require(:product).permit(:name)
    end


  end
  