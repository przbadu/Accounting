require 'rails_helper'

RSpec.describe Api::V1::RevenuesController, type: :controller do
  context '#show' do
    it 'should return 404' do
      get :show, params: { id: 1 }

      expect_status :not_found
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    it 'should return revenue with id' do
      sales = create(:sales)
      get :show, params: { id: sales.id }

      expect_status 200
      expect_json(
        id: sales.id,
        name: 'Sales',
        type: 'Plutus::Revenue',
        contra: nil
      )
    end
  end

  context '#Create' do
    it 'should have permitted params' do
      post :create

      expect_status 400
      expect_json(global_errors: "param is missing or the value is empty: revenue")
    end

    it 'name should not be blank' do
      post :create, params: { revenue: {fake: 'params'} }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"]})
    end

    it 'name should be unique' do
      create(:revenue)
      post :create, params: { revenue: { name: 'Sales' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should create an revenue' do
      post :create, params: { revenue: { name: 'Sales' } }

      expect_status 200
      expect_json(
        id: Plutus::Revenue.first.id,
        name: 'Sales',
        type: 'Plutus::Revenue',
        contra: nil
      )
    end
  end

  context '#Update' do
    before { @revenue = create(:sales) }

    it 'name should not be blank' do
      put :update, params: { id: @revenue.id, revenue: { name: '' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"] })
    end

    it 'name should be unique' do
      create(:revenue, name: 'Interest')
      put :update, params: {
        id: @revenue.id,
        revenue: { name: 'Interest' }
      }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should update record' do
      put :update, params: { id: @revenue.id, revenue: { name: 'updated' } }

      expect_json(
        id: @revenue.id,
        name: 'updated'
      )
    end
  end
end
