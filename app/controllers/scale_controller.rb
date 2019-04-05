class ScaleController < ApplicationController
  before_action :logged_in_user
  def new
    @scale = Scale.new()
  end

  def show

  end

  def index
    @scale = Scale.all
  end

  def create

  end

  def destroy

  end

  def update

  end

  def edit

  end
end
