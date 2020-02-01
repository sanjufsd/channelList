class ListingsController < ApplicationController
  before_action :require_login
  before_action :set_listing, only: [:edit, :update, :destroy]

  def new
    @listing = Listing.new
    @listing.show = Show.find_by(id: params[:show_id])
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.show = Show.find_by(id: params[:show_id])
    if @listing.save
      flash[:message] = "#{@listing.show.title} has been added to your watchlist"
      redirect_to show_path(@listing.show)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @listing.update(listing_params)
    if @listing.save
      flash[:message] = "#{@listing.show.title} listing has been updated"
      redirect_to show_path(@listing.show)
    else
      render :edit
    end
  end

  def destroy
    if @listing
      @listing.destroy
      flash[:message] = "The show has been removed from your watchlist"
      redirect_to watchlists_path
    else
      flash[:danger] = "The show could not be removed"
      render 'shows/show'
    end
  end

  private
  def listing_params
    params.require(:listing).permit(:watchlist_id, :user_id, :user_status, :user_season, :fav)
  end

  def set_listing
    @listing = Listing.find_by(id: params[:id])
  end
end
