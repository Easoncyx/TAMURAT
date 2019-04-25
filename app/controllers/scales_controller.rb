class ScalesController < ApplicationController
  before_action :admin_user, only: [:destroy, :new, :create, :edit, :update]
  before_action :set_scale, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user


  # GET /scales
  # GET /scales.json
  def index
    @scales = Scale.all
    @all_categories_name = Category.distinct.pluck(:name)
    @selected_categories_name = []
    redirect_flag = false

    if params[:categories]
      @selected_categories_name = params[:categories].keys
      session[:categories] = params[:categories]
    elsif session[:categories]
      @selected_categories_name = session[:categories].keys
      redirect_flag = true
    else
      @selected_categories_name = Category.distinct.pluck(:name)
    end

    if redirect_flag
      # flash.keep
      redirect_to scales_path(categories: session[:categories])
    else
      @selected_categories_id = Category.where(name: @selected_categories_name).map{|t| t.id}
      @scales = Scale.where(category_id: @selected_categories_id).order(:id)
    end
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
    if(scale_params[:score] =~ Scale.valid_weight_regex)
      @scale = Scale.new(scale_params)
      if @scale.save
        flash[:info] = "Scale was successfully created."
        redirect_to scales_path
      else
        #byebug
        flash[:danger] = "Scale update failed."
        render 'new'
      end
    else
      flash[:danger] = "Score Invalid, you need to type a float."
      redirect_to new_scale_url
    end
  end

  def update
    if(scale_params[:score] =~ Scale.valid_weight_regex)
      if @scale.update(scale_params)
        flash[:success] = "Scale was successfully updated."
        redirect_to scales_url
      else
        flash[:danger] = "Scale update failed."
        render 'edit'
      end
    else
      flash[:danger] = "Score Invalid, you need to type a float."
      redirect_to edit_scale_path(params[:id])
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
      @scale = Scale.find_by_id(params[:id])
      if !@scale
        flash[:warning] = "Select a valid scale id."
        redirect_to scales_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scale_params
      params.fetch(:scale, {}).permit(:name, :category_id, :level, :score, :description)
    end
end
