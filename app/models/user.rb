class User < ApplicationRecord
  has_many :watchlists
  has_many :listings
  has_many :shows, through: :listings

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true

  has_secure_password

  def favorite_shows
    # List the user's shows where fav is true
    self.shows.includes(:listings).where(:listings => { fav: true }).uniq
  end
end
