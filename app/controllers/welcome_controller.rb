class WelcomeController < ApplicationController
  def index
    @listings =Listing.all.limit(4)
  end
end