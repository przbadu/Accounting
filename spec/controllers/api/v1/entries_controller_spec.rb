require 'rails_helper'

RSpec.describe Api::V1::EntriesController, type: :controller do
  let(:debit_params) {{ debits: [{ account_name: 'Cash', amount: 100.00 }]}}
  let(:credit_params) {
    { credits: [{ account_name: 'Unearned Revenue', amount: 100.00 }]}
  }
  let(:valid_params) {
    { entry: attributes_for(:entry).merge(debit_params).merge(credit_params) }
  }

  context '#Index' do
    it 'should return empty array' do
      get :index

      expect_status 200
      expect_json([])
    end

    it 'should return list of entries' do
      Plutus::Asset.create(name: 'Cash')
      Plutus::Liability.create(name: 'Unearned Revenue')
      entry = Plutus::Entry.create(valid_params[:entry])
      entry2 = Plutus::Entry.create(valid_params[:entry])

      get :index

      expect_status 200
      expect_json_sizes(2)
      expect_json('0', id: entry.id, description: entry.description)
      expect_json_sizes('0.debit_amounts', 1)
      expect_json_sizes('0.credit_amounts', 1)

      expect_json('1', id: entry2.id, description: entry2.description)
      expect_json_sizes('1.debit_amounts', 1)
      expect_json_sizes('1.credit_amounts', 1)
    end

    it 'should paginate list of entries'
  end

  context '#Show' do
    it 'should return 404 Not Found' do
      get :show, params: { id: 1 }

      expect_status 404
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    it 'should return entry by id' do
      Plutus::Asset.create(name: 'Cash')
      Plutus::Liability.create(name: 'Unearned Revenue')
      entry = Plutus::Entry.create(valid_params[:entry])
      initialize_objects

      get :show, params: { id: entry.id }

      expect_json(
        id: entry.id,
        description: entry.description,
        date: '2017-10-02'
      )

      expect_json(
        'debit_amounts.0',
        id: @debit.id,
        type: @debit.type,
        amount: @debit.amount.to_s,
        entry_id: entry.id,
        account_id: @debit_account.id
      )
      expect_json(
        'credit_amounts.0',
        id: @credit.id,
        type: @credit.type,
        amount: @credit.amount.to_s,
        entry_id: entry.id,
        account_id: @credit_account.id
      )
      expect_status 200
    end
  end

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
      expect_status :unprocessable_entity
    end

    it 'Debit and credit chart of account must exists before using them' do
      post :create, params: valid_params

      expect_status 404
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    context 'Chart of account exists' do
      before do
        Plutus::Asset.create(name: 'Cash')
        Plutus::Liability.create(name: 'Unearned Revenue')
      end

      it 'Debit and Credit should balance' do
        post :create, params: {
          entry: attributes_for(:entry)
            .merge(debit_params)
            .merge({
            credits: [{
              account_name: 'Unearned Revenue',
              amount: 80.00
            }]
          })
        }

        expect_json(errors: {
          base: ['The credit and debit amounts are not equal']
        })
        expect_status :unprocessable_entity
      end

      it 'should create entry with reference to account' do
        post :create, params: valid_params
        initialize_objects

        expect_status 200
        expect_json(description: 'Order placed for widgets')
        expect_json(id: @entry.id)
        expect_json(date: '2017-10-02')
        expect_json(
          'debit_amounts.0',
          id: @debit.id,
          type: @debit.type,
          amount: @debit.amount.to_s,
          entry_id: @entry.id,
          account_id: @debit_account.id
        )
        expect_json(
          'credit_amounts.0',
          id: @credit.id,
          type: @credit.type,
          amount: @credit.amount.to_s,
          entry_id: @entry.id,
          account_id: @credit_account.id
        )
      end
    end
  end

  context "#update" do
    it 'should raise validation error' do
      Plutus::Asset.create(name: 'Cash')
      Plutus::Liability.create(name: 'Unearned Revenue')
      entry = Plutus::Entry.create(valid_params[:entry])

      put :update, params: { id: entry.id, entry: { description: '' } }

      expect_json(errors: { description: ["can't be blank"]})
      expect_status :unprocessable_entity
    end

    it 'Debit and credit chart of account must exists before using them' do
      Plutus::Asset.create(name: 'Cash')
      Plutus::Liability.create(name: 'Unearned Revenue')
      entry = Plutus::Entry.create(valid_params[:entry])

      put :update, params: {
        id: entry.id,
        entry: {
          debits: [{ account_name: 'new account head' }]
        }
      }

      expect_status 404
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    context 'Chart of account exists' do
      before do
        Plutus::Asset.create(name: 'Cash')
        Plutus::Liability.create(name: 'Unearned Revenue')
        @entry = Plutus::Entry.create(valid_params[:entry])
      end

      it 'Debit and Credit should balance' do
        put :update, params: {
          id: @entry.id,
          entry: {
            debits: [{
              id: @entry.debit_amounts.first.id,
              amount: 10
            }]
          }
        }

        expect_json(errors: {
          base: ['The credit and debit amounts are not equal']
        })
      end

      it 'Should delete nested attribute' do
        debit_amount = @entry.debit_amounts.first
        expect(Plutus::DebitAmount.count).to eq(1)
        put :update, params: {
          id: @entry.id,
          entry: {
            debits: [{
              id: @entry.debit_amounts.first.id,
              amount: 100.00,
              _destroy: '1'
            }]
          }
        }

        expect_json(errors: {
          base: ['The credit and debit amounts are not equal']
        })
      end

      it 'should update entry with nested attributes' do
        put :update, params: {
          id: @entry.id,
          entry: {
            description: 'updated',
            debits: [{ id: @entry.debit_amounts.first.id, amount: 120.00 }],
            credits: [{ id: @entry.credit_amounts.first.id, amount: 120.00 }]
          }
        }

        initialize_objects

        expect_json(description: 'updated')
        expect_json(id: @entry.id)
        expect_json(date: '2017-10-02')
        expect_json(
          'debit_amounts.0',
          id: @debit.id,
          type: @debit.type,
          amount: 120.00.to_s,
          entry_id: @entry.id,
          account_id: @debit_account.id
        )
        expect_json(
          'credit_amounts.0',
          id: @credit.id,
          type: @credit.type,
          amount: 120.00.to_s,
          entry_id: @entry.id,
          account_id: @credit_account.id
        )
      end
    end
  end
end

def initialize_objects
  @entry = Plutus::Entry.first
  @debit = Plutus::DebitAmount.first
  @credit = Plutus::CreditAmount.first
  @debit_account = Plutus::Account.find_by_name 'Cash'
  @credit_account = Plutus::Account.find_by_name 'Unearned Revenue'
end
