class ListsController < ApplicationController
  before_action :authenticate_user!, only: :my

  def my
    @lists = List.where(user: current_user)
  end

end