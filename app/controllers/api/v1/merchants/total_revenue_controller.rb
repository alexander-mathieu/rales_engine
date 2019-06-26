class Api::V1::Merchants::TotalRevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.total_revenue(params[:date]))
  end
end
