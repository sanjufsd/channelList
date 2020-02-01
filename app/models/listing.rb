class Listing < ApplicationRecord
  belongs_to :watchlist
  belongs_to :show
  belongs_to :user

  validates :user_season, presence: true, numericality: { greater_than: 0 }
  validates :watchlist_id, uniqueness: { scope: :show_id }, :on => :create
  validate :user_season_vs_current_season

  def user_season_vs_current_season
    if user_season.present? && user_season > show.current_season
      errors.add(:user_season, "can't be ahead of the show's Season #{show.current_season}")
    end
  end
end
