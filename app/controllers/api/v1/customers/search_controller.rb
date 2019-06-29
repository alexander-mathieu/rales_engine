class Api::V1::Customers::SearchController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.search_all_by(search_params))
  end

  def show
    if search_params.empty?
      render json: CustomerSerializer.new(Customer.find_random)
    else
      render json: CustomerSerializer.new(Customer.search_by(search_params))
    end
  end

  private

  def search_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
