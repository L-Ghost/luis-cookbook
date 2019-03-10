class ListsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :my]
  
  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(name: params[:list][:name], user: current_user)
    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  def my
    @lists = List.where(user: current_user)
  end

end