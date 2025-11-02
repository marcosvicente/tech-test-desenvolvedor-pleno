class CustomersController < ApplicationController
  def index
    @customers = Customer.order(created_at: :desc).page(params[:page])
  end
end
