class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :update]

  # GET /entries
  def index
    # TODO add pagination
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
      render json: { errors: @entry.errors }
    end
  end

  # PUT /entries/1
  def update

  end

  private

  def set_entry
    @entry = Plutus::Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(
      :description,
      :date,
      debits: [:account_name, :amount],
      credits: [:account_name, :amount]
    )
  end
end
