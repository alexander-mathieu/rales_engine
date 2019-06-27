class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])

    render json: CustomerSerializer.new(merchant.favorite_customer)
  end
end
