class HomeController < ApplicationController
  def index
    @taxis = Taxi.all.limit(20)
    @users = User.all.limit(20)
    @items = Item.all.limit(20)

    
  end
end
