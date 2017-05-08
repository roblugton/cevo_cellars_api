class CellarsController < ApplicationController
    before_action :set_cellar, only: [:show, :update, :destroy]

    #GET /cellars
    def index
        @cellars = Cellar.all
        json_response(@cellars)
    end

    # GET /cellars/:id
    def show
        json_response(@cellar)
    end

    private

    def cellar_params
        # whitelist params
        params.permit(:name)
    end

    def set_cellar
        @cellar = Cellar.find(params[:id])
    end
end
