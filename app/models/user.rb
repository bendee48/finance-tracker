class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  def self.search(query, current_user)
    query.downcase!
    where('lower(email) LIKE ?', "%#{query}%" )
      .or(where('lower(firstname) LIKE ?', "%#{query}%"))
      .or(where('lower(lastname) LIKE ?', "%#{query}%"))
      .where.not(id: current_user.id)
  end

  def tracked?(ticker)
    stocks.find_by(ticker: ticker.upcase).present?
  end

  def tracked_limit?
    stocks.count > 9
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def friends?(friend)
    friends.where(id: friend.id).exists?
  end
end
