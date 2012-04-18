class UsersController < ApplicationController
  
  attr_accessor :name, :email #klassvariabler
  
  def new
    @title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  
end
