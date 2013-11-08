class HomeController < ApplicationController
  # load_and_authorize_resource #cancan method


  def index
    @taxis = Taxi.all.limit(20)
    @users = User.all.limit(20)
    @items = Item.all.limit(20)
  end
end
