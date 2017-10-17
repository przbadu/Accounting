class Api::V1::RevenuesController < Api::V1::BaseController
  before_action :set_revenue, only: [:show, :update]

  def show
    render json: @revenue
  end

  def create
    @revenue = Plutus::Revenue.new(revenue_params)

    if @revenue.save
      render json: @revenue
    else
      render json: { errors: @revenue.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @revenue.update(revenue_params)
      render json: @revenue
    else
      render json: { errors: @revenue.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_revenue
    @revenue = Plutus::Revenue.find(params[:id])
  end

  def revenue_params
    params.require(:revenue).permit(:name)
  end
end
