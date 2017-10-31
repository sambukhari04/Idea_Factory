class HomeController < ApplicationController

  def index
    @ideas = Idea.limit(7)
    @users = User.all
  end
end
