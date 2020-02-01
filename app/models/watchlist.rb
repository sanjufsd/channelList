class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :listings
  has_many :shows, through: :listings

  validates :name, presence: true

  before_destroy :destroy_listings

  private
  def destroy_listings
    self.listings.each do |listing|
      listing.destroy
    end
  end
end
