class StocksController < ApplicationController
  def search
    if params[:ticker].present?
      @stock = Stock.look_up(params[:ticker])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now.alert = "Invalid ticker symbol."
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now.alert = "Search field can't be blank."
        format.js { render partial: 'users/result' }
      end
    end
  end
end
