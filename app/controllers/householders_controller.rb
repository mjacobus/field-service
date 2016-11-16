class HouseholdersController < ApplicationController
  before_action :set_householder, only: [:show, :edit, :update, :destroy]

  def index
    @householders = Householder.all
  end

  def show
  end

  def new
    @householder = Householder.new
  end

  def edit
  end

  def create
    @householder = Householder.new(householder_params)

    if @householder.save
      redirect_to @householder, notice: 'Householder was successfully created.'
    else
      render :new
    end
  end

  def update
    if @householder.update(householder_params)
      redirect_to @householder, notice: 'Householder was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @householder.destroy
    redirect_to householders_url, notice: 'Householder was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_householder
    @householder = Householder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def householder_params
    params.require(:householder).permit(:territory_id, :street_name, :house_number, :name, :show)
  end
end
