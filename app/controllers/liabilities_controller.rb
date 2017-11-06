class LiabilitiesController < ApplicationController
  before_action :set_liability, only: [:show, :update]

  def show
    render json: @liability
  end

  def create
    @liability = Plutus::Liability.new(liability_params)

    if @liability.save
      render json: @liability
    else
      render json: { errors: @liability.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @liability.update(liability_params)
      render json: @liability
    else
      render json: { errors: @liability.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_liability
    @liability = Plutus::Liability.find(params[:id])
  end

  def liability_params
    params.require(:liability).permit(:name)
  end
end
