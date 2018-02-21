class WelcomeController < ApplicationController
  def index
    @listings =Listing.all.limit(3)
  end
end