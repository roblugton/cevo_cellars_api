class BottlesController < ApplicationController
  before_action :set_cellar
  before_action :set_cellar_bottle, only: [:show, :update, :destroy]

  # GET /cellars/:cellar_id/bottles
  def index
    json_response(@cellar.bottles)
  end

  # GET /cellars/:cellar_id/bottles/:id
  def show
    json_response(@bottle)
  end

  # POST /cellars/:cellar_id/bottles
  def create
    @cellar.bottles.create!(bottle_params)
    json_response(@cellar, :created)
  end

  # PUT /cellars/:cellar_id/bottles/:id
  def update
    @bottle.update(bottle_params)
    head :no_content
  end

  # DELETE /cellars/:cellar_id/bottles/:id
  def destroy
    @bottle.destroy
    head :no_content
  end

  private

  def bottle_params
    params.permit(:name, :varietal, :winery, :vintage, :description)
  end

  def set_cellar
    @cellar = Cellar.find(params[:cellar_id])
  end

  def set_cellar_bottle
    @bottle = @cellar.bottles.find_by!(id: params[:id]) if @cellar
  end

end
