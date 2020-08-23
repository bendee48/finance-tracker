class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def tracked?(ticker)
    stocks.find_by(ticker: ticker.upcase).present?
  end

  def tracked_limit?
    stocks.count > 9
  end
end
