class Show < ApplicationRecord
  has_many :listings
  has_many :watchlists, through: :listings
  has_many :users, through: :listings
  has_many :show_genres
  has_many :genres, through: :show_genres
  belongs_to :channel

  validates :title, presence: true, uniqueness: { scope: :channel_id } # Validates uniqueness of title and channel
  validates :current_season, presence: true, numericality: { greater_than: 0 }

  scope :search, -> (query) { where("title LIKE ?", "%" + query + "%") }
  scope :behind_on, -> (user_id) { joins(:listings).where('shows.current_season > listings.user_season').where(listings: {user_id: user_id}).uniq }

  def channel_attributes=(channel_attributes)
    channel_attributes.values.each do |channel_attribute|
      unless channel_attribute.blank?
        channel = Channel.find_or_create_by(name: channel_attribute)
        self.channel = channel
      end
    end
  end

  def genres_attributes=(genre_attributes)
    genre_name = genre_attributes["0"]["name"]
    unless genre_name.blank?
      genre = Genre.find_or_create_by(name: genre_name)
      self.genres << genre
    end
  end

  def shows_watchlists_by_user(user_id)
    self.listings.where(user_id: user_id)
  end
end
