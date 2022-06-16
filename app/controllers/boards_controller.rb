class BoardsController < ApplicationController
  def index
  end

  def show
    p params
    @user = User.find(params[:format])
    p @user
  end
end
