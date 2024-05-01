# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
    include ApplicationHelper
    before_action :set_order, only: [:update]
  
    # POST /orders
    def create
      @order = Order.new(order_params)
  
      if @order.save
        notify_third_parties('Order', "Order placed: #{@order}")
        render json: @order, status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /orders/1
    def update
      if @order.update(order_params)
        # notify_third_parties('Order', "Order updated: #{@order}")
        render json: @order
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_order
      @order = Order.find(params[:id])
    end
  
    def order_params
      params.require(:order).permit(:customer_id, :product_id, :quantity)
    end
  end
  