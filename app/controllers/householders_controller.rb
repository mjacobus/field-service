class HouseholdersController < ApplicationController
  def index
    householders = Householder.all
    @householders_view = create_view(Householders::CollectionView, householders)
  end

  def show
    householder = find_householder
    @householder_view = create_view(Householders::ItemView, householder)
  end

  def new
    householder = Householder.new
    @householder_view = create_view(Householders::ItemView, householder)
  end

  def edit
    householder = find_householder
    @householder_view = create_view(Householders::ItemView, householder)
  end

  def create
    householder = Householder.new(householder_params)
    @householder_view = create_view(Householders::ItemView, householder)

    if householder.save
      redirect_to @householder_view.url, notice: 'Householder was successfully created.'
    else
      render :new
    end
  end

  def update
    householder = find_householder
    @householder_view = create_view(Householders::ItemView, householder)

    if householder.update(householder_params)
      redirect_to @householder_view.url, notice: 'Householder was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    householder = find_householder
    householder.destroy
    @householder_view = create_view(Householders::ItemView, householder)

    redirect_to @householder_view.index_url, notice: 'Householder was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_householder
    Householder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def householder_params
    params.require(:householder).permit(:territory_id, :street_name, :house_number, :name, :show)
  end
end
