class EquitiesController < ApplicationController
  before_action :set_equity, only: [:show, :update]

  def show
    render json: @equity
  end

  def create
    @equity = Plutus::Equity.new(equity_params)

    if @equity.save
      render json: @equity
    else
      render json: { errors: @equity.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @equity.update(equity_params)
      render json: @equity
    else
      render json: { errors: @equity.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_equity
    @equity = Plutus::Equity.find(params[:id])
  end

  def equity_params
    params.require(:equity).permit(:name)
  end
end
