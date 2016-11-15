class HouseholdersController < ApplicationController
  before_action :set_householder, only: [:show, :edit, :update, :destroy]

  # GET /householders
  # GET /householders.json
  def index
    @householders = Householder.all
  end

  # GET /householders/1
  # GET /householders/1.json
  def show
  end

  # GET /householders/new
  def new
    @householder = Householder.new
  end

  # GET /householders/1/edit
  def edit
  end

  # POST /householders
  # POST /householders.json
  def create
    @householder = Householder.new(householder_params)

    respond_to do |format|
      if @householder.save
        format.html { redirect_to @householder, notice: 'Householder was successfully created.' }
        format.json { render :show, status: :created, location: @householder }
      else
        format.html { render :new }
        format.json { render json: @householder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /householders/1
  # PATCH/PUT /householders/1.json
  def update
    respond_to do |format|
      if @householder.update(householder_params)
        format.html { redirect_to @householder, notice: 'Householder was successfully updated.' }
        format.json { render :show, status: :ok, location: @householder }
      else
        format.html { render :edit }
        format.json { render json: @householder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /householders/1
  # DELETE /householders/1.json
  def destroy
    @householder.destroy
    respond_to do |format|
      format.html { redirect_to householders_url, notice: 'Householder was successfully destroyed.' }
      format.json { head :no_content }
    end
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
