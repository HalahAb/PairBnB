class WelcomeController < ApplicationController
  def index
    @listings =Listing.all.limit(6)
  end
end