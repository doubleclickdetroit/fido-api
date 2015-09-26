class OccasionsController < ApplicationController
  before_action :set_occasion, only: [:show, :update, :destroy]

  # GET /occasions
  # GET /occasions.json
  def index
    @occasions = current_user.occasions
    render json: @occasions
  end

  # GET /occasions/1
  # GET /occasions/1.json
  def show
    render json: @occasion
  end

  # POST /occasions
  # POST /occasions.json
  def create
    @occasion = current_user.occasions.new(occasion_params)

    if @occasion.save
      render json: @occasion, status: :created, location: @occasion
    else
      render json: @occasion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /occasions/1
  # PATCH/PUT /occasions/1.json
  def update
    if @occasion.update(occasion_params)
      head :no_content
    else
      render json: @occasion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /occasions/1
  # DELETE /occasions/1.json
  def destroy
    @occasion.destroy

    head :no_content
  end

  private

    def set_occasion
      @occasion = current_user.occasions.find(params[:id])
    end

    def occasion_params
      params.require(:occasion).permit(:label, :date, :contact_id)
    end
end
