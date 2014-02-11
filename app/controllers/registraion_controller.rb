class RegistraionController < ApplicationController
  def new
    @registration = User.new
  end

  def create
    @registration = User.new
  end
end
