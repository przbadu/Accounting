require 'rails_helper'

RSpec.describe Api::V1::LiabilitiesController, type: :controller do
  context '#show' do
    it 'should return 404' do
      get :show, params: { id: 1 }

      expect_status :not_found
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    it 'should return liability with id' do
      liability = create(:liability)
      get :show, params: { id: liability.id }

      expect_status 200
      expect_json(
        id: liability.id,
        name: 'Unearned revenue',
        type: 'Plutus::Liability',
        contra: nil
      )
    end
  end

  context '#Create' do
    it 'should have permitted params' do
      post :create

      expect_status 400
      expect_json(global_errors: "param is missing or the value is empty: liability")
    end

    it 'name should not be blank' do
      post :create, params: { liability: {fake: 'params'} }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"]})
    end

    it 'name should be unique' do
      create(:liability)
      post :create, params: { liability: { name: 'Unearned revenue' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should create an liability' do
      post :create, params: { liability: { name: 'Unearned revenue' } }

      expect_status 200
      expect_json(
        id: Plutus::Liability.first.id,
        name: 'Unearned revenue',
        type: 'Plutus::Liability',
        contra: nil
      )
    end
  end

  context '#Update' do
    before { @liability = create(:liability) }

    it 'name should not be blank' do
      put :update, params: { id: @liability.id, liability: { name: '' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"] })
    end

    it 'name should be unique' do
      create(:liability, name: 'Account payable')
      put :update, params: {
        id: @liability.id,
        liability: { name: 'Account payable' }
      }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should update record' do
      put :update, params: { id: @liability.id, liability: { name: 'updated' } }

      expect_json(
        id: @liability.id,
        name: 'updated'
      )
    end
  end
end
