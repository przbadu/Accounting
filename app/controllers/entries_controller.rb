class EntriesController < ApplicationController
  # GET /entries
  def index

  end

  # GET /entries/1
  def show

  end

  # POST /entries
  def create

  end

  # PUT /entries/1
  def update

  end

  private

  def entry_params
    params.require(:entry).permit(
      :description,
      :date,
      debits: [:account_name, :amount],
      credits: [:account_name, :amount]
    )
  end
end
