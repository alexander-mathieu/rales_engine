class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    if search_params["unit_price"].class == String
      deserialize_unit_price

      render json: InvoiceItemSerializer.new(InvoiceItem.search_all_by(search_params))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.search_all_by(search_params))
    end
  end

  def show
    if search_params.empty?
      render json: InvoiceItemSerializer.new(InvoiceItem.find_random)
    elsif search_params["unit_price"].class == String
      deserialize_unit_price

      render json: InvoiceItemSerializer.new(InvoiceItem.search_by(search_params))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.search_by(search_params))
    end
  end

  private

  def deserialize_unit_price
    unit_price_params = {}
    unit_price_params["unit_price"] = search_params["unit_price"].sub!('.', '').to_i
  end

  def search_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
