class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: TotalRevenueSerializer.new(Merchant.total_date_revenue(params[:date]))
  end

  def show
    merchant = Merchant.find(params[:id])

    if params[:date]
      render json: RevenueSerializer.new(merchant.date_revenue(params[:date]))
    else
      render json: RevenueSerializer.new(merchant.revenue)
    end
  end
end
