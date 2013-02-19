class UsersController < ApplicationController
  def new
    @user= User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      ## flash is a local variable. After render view, create method calls 'new' and finishes.
      flash[:error] = "Please read error messages, fill in form and resubmit."
      render 'new'
    end
  end
  
end
