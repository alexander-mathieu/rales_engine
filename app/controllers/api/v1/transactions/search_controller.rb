class Api::V1::Transactions::SearchController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.search_all_by(search_params))
  end

  def show
    if search_params.empty?
      render json: TransactionSerializer.new(Transaction.find_random)
    else
      render json: TransactionSerializer.new(Transaction.search_by(search_params))
    end
  end

  private

  def search_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end
end
