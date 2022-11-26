class SpicesController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
   
    def index
        spices = Spice.all
        render json: spices, status: :ok
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = Spice.find_by(id: params[:id])
        spice.update(spice_params)
        render json: spice, status: :accepted
    end

    def destroy
        spice = Spice.find_by(id: params[:id])
        spice.destroy
        head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_space
        Spice.find(params[:id])
    end

    def render_not_found_response
        render json: { errpr: "Spice not found" }, status: :not_found
    end
end