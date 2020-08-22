class UserStocksController < ApplicationController
  def create
    stock = Stock.find_by(ticker: params[:ticker])
    if stock
      UserStock.create(user_id: current_user, stock_id: stock)
    else
      stock = Stock.look_up(params[:ticker])
      stock.save
      UserStock.create(user_id: current_user.id, stock_id: stock.id)
    end
    flash.notice = "Stock #{stock.name} succesfully added to your portfolio."
    redirect_to my_portfolio_path
  end
end
