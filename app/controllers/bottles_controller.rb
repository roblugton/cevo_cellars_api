class BottlesController < ApplicationController
  before_action :set_cellar
  before_action :set_cellar_bottle, only: [:show]

  # GET /cellars/:cellar_id/bottles
  def index
    json_response(@cellar.bottles)
  end

  def show
    json_response(@bottle)
  end

  private

  def set_cellar
    @cellar = Cellar.find(params[:cellar_id])
  end

  def set_cellar_bottle
    @bottle = @cellar.bottles.find_by!(id: params[:id]) if @cellar
  end

end
