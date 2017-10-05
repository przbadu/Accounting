require 'rails_helper'

RSpec.describe EquitiesController, type: :controller do
  context '#show' do
    it 'should return 404' do
      get :show, params: { id: 1 }

      expect_status :not_found
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    it 'should return equity with id' do
      equity = create(:drawing)
      get :show, params: { id: equity.id }

      expect_status 200
      expect_json(
        id: equity.id,
        name: 'Drawing',
        type: 'Plutus::Equity',
        contra: true
      )
    end
  end

  context '#Create' do
    it 'should have permitted params' do
      post :create

      expect_status 400
      expect_json(global_errors: "param is missing or the value is empty: equity")
    end

    it 'name should not be blank' do
      post :create, params: { equity: {fake: 'params'} }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"]})
    end

    it 'name should be unique' do
      create(:drawing)
      post :create, params: { equity: { name: 'Drawing' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should create an equity' do
      post :create, params: { equity: { name: 'Drawing', contra: true } }

      expect_status 200
      expect_json(
        id: Plutus::Equity.first.id,
        name: 'Drawing',
        type: 'Plutus::Equity',
        contra: true
      )
    end
  end

  context '#Update' do
    before { @equity = create(:drawing) }

    it 'name should not be blank' do
      put :update, params: { id: @equity.id, equity: { name: '' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"] })
    end

    it 'name should be unique' do
      create(:equity, name: 'existing')
      put :update, params: { id: @equity.id, equity: { name: 'existing' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should update record' do
      put :update, params: { id: @equity.id, equity: { name: 'updated' } }

      expect_json(
        id: @equity.id,
        name: 'updated'
      )
    end
  end
end
