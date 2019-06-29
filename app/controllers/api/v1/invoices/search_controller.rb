class Api::V1::Invoices::SearchController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.search_all_by(search_params))
  end

  def show
    if search_params.empty?
      render json: InvoiceSerializer.new(Invoice.find_random)
    else
      render json: InvoiceSerializer.new(Invoice.search_by(search_params))
    end
  end

  private

  def search_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
