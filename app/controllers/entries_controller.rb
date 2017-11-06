class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :update]

  # GET /entries
  def index
    render json: Plutus::Entry.all
  end

  # GET /entries/1
  def show
    render json: @entry
  end

  # POST /entries
  def create
    @entry = Plutus::Entry.create(entry_params)

    if @entry.save
      render json: @entry
    else
      render json: { errors: @entry.errors }, status: :unprocessable_entity
    end
  end

  # PUT /entries/1
  def update
    if @entry.update(entry_params)
      render json: @entry
    else
      render json: { errors: @entry.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_entry
    @entry = Plutus::Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(
      :description,
      :date,
      debits: [:id, :account_name, :amount, :_destroy],
      credits: [:id, :account_name, :amount, :_destroy]
    )
  end
end
