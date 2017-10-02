require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:valid_params) {
    {
      entry: {
        description: 'Order placed for widgets',
        date: Date.yesterday,
        debits: [
          {
            account_name: 'Cash',
            amount: 100.00
          }
        ],
        credits: [
          {
            account_name: 'Unearned Revenue',
            amount: 100.00
          }
        ]
      }
    }
  }

  context '#create' do
    it 'should raise validation error' do
      post :create, params: { entry: { fake: 'params' } }

      expect_json(errors: {
        description: ["can't be blank"],
        base: [
          'Entry must have at least one credit amount',
          'Entry must have at least one debit amount'
        ]
      })
    end
  end
end
