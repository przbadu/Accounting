require 'rails_helper'

RSpec.describe Api::V1::ExpensesController, type: :controller do
  context '#show' do
    it 'should return 404' do
      get :show, params: { id: 1 }

      expect_status :not_found
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    it 'should return expense with id' do
      salary = create(:salary)
      get :show, params: { id: salary.id }

      expect_status 200
      expect_json(
        id: salary.id,
        name: 'Salary',
        type: 'Plutus::Expense',
        contra: nil
      )
    end
  end

  context '#Create' do
    it 'should have permitted params' do
      post :create

      expect_status 400
      expect_json(global_errors: "param is missing or the value is empty: expense")
    end

    it 'name should not be blank' do
      post :create, params: { expense: {fake: 'params'} }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"]})
    end

    it 'name should be unique' do
      create(:expense)
      post :create, params: { expense: { name: 'Salary' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should create an expense' do
      post :create, params: { expense: { name: 'Salary' } }

      expect_status 200
      expect_json(
        id: Plutus::Expense.first.id,
        name: 'Salary',
        type: 'Plutus::Expense',
        contra: nil
      )
    end
  end

  context '#Update' do
    before { @expense = create(:salary) }

    it 'name should not be blank' do
      put :update, params: { id: @expense.id, expense: { name: '' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"] })
    end

    it 'name should be unique' do
      create(:expense, name: 'Interest Paid')
      put :update, params: {
        id: @expense.id,
        expense: { name: 'Interest Paid' }
      }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should update record' do
      put :update, params: { id: @expense.id, expense: { name: 'updated' } }

      expect_json(
        id: @expense.id,
        name: 'updated'
      )
    end
  end
end
