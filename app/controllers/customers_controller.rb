# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
    include ApplicationHelper
    before_action :set_customer, only: [:update]
  
    # POST /customers
    def create
      @customer = Customer.new(customer_params)
  
      if @customer.save
        notify_third_parties('Customer', "Customer created: #{@customer}")
        render json: @customer, status: :created
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /customers/1
    def update
      if @customer.update(customer_params)
        notify_third_parties('Customer', "Customer updated: #{@customer}")
        render json: @customer
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_customer
      @customer = Customer.find(params[:id])
    end
  
    def customer_params
      params.require(:customer).permit(:name, :email, :address)
    end
  end
  