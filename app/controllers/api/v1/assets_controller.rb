class Api::V1::AssetsController < Api::V1::BaseController
  before_action :set_asset, only: [:show, :update]

  def show
    render json: @asset
  end

  def create
    @asset = Plutus::Asset.new(assets_params)

    if @asset.save
      render json: @asset
    else
      render json: { errors: @asset.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @asset.update(assets_params)
      render json: @asset
    else
      render json: { errors: @asset.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_asset
    @asset = Plutus::Asset.find(params[:id])
  end

  def assets_params
    params.require(:asset).permit(:name, :contra)
  end
end
