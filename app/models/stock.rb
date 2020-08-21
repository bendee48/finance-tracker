class Stock < ApplicationRecord

  def self.look_up(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.dig(:iex, :iex_publishable_token),
      secret_token: Rails.application.credentials.dig(:iex, :iex_secret_token),
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    client.price(ticker_symbol)
  end
end
