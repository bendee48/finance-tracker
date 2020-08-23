class Stock < ApplicationRecord
  has_many :user_stocks, dependent: :destroy
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  before_save do
    ticker.upcase!
  end

  def self.look_up(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.dig(:iex, :iex_publishable_token),
      secret_token: Rails.application.credentials.dig(:iex, :iex_secret_token),
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(name: client.company(ticker_symbol).company_name,
          ticker: ticker_symbol,
          price: client.price(ticker_symbol)
      )
    rescue
      return nil
    end
  end
end
