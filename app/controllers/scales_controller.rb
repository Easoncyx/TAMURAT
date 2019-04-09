class ScalesController < ApplicationController
  before_action :set_scale, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :admin_user

  # GET /scales
  # GET /scales.json
  def index
    @scales = Scale.all
    @all_categories_name = Category.distinct.pluck(:name)
    @selected_categories_name = []
  end

  # GET /scales/1
  # GET /scales/1.json
  def show
  end

  # GET /scales/new
  def new
    @scale = Scale.new
  end

  # GET /scales/1/edit
  def edit
  end

  # POST /scales
  # POST /scales.json
  def create
    @scale = Scale.new(scale_params)
    if @scale.save
      flash[:info] = "Scale was successfully created."
      redirect_to scales_path
    else
      render 'new'
    end
  end

  def update
    if @scale.update(scale_params)
      flash[:success] = "Scale was successfully updated."
      redirect_to scales_url
    else
      render 'edit'
    end
  end


  def destroy
     @scale.destroy
     flash[:success] = "Scale deleted"
     redirect_to scales_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scale
      @scale = Scale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scale_params
      params.fetch(:scale, {}).permit(:name, :category_id, :level, :score)
    end
end
