class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.search_all_by(search_params))
  end

  def show
    if search_params.empty?
      render json: MerchantSerializer.new(Merchant.find_random)
    else
      render json: MerchantSerializer.new(Merchant.search_by(search_params))
    end
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
