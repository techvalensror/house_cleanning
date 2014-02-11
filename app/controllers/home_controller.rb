class HomeController < ApplicationController
  def index
  end

  def welcome
    @update_password = User.where(:id => params[:id]).first
  end


end
