class StocksController < ApplicationController
  def search
    if params[:ticker].present?
      @stock = Stock.look_up(params[:ticker])
      if @stock
        render 'users/my_portfolio'
      else
        flash.alert = "Invalid ticker symbol."
        redirect_to my_portfolio_path
      end
    else
      flash.alert = "Search field can't be blank."
      redirect_to my_portfolio_path
    end
  end
end
