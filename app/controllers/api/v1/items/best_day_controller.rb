class Api::V1::Items::BestDayController < ApplicationController
  def index
    item = Item.find(params[:id])

    render json: DateSerializer.new(item.best_day)
  end
end
