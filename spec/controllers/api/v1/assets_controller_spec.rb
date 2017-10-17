require 'rails_helper'

RSpec.describe AssetsController, type: :controller do
  context '#show' do
    it 'should return 404' do
      get :show, params: { id: 1 }

      expect_status :not_found
      expect_json(global_errors: "Couldn't find resource with given id")
    end

    it 'should return asset with id' do
      asset = create(:cash)
      get :show, params: { id: asset.id }

      expect_status 200
      expect_json(
        id: asset.id,
        name: 'Cash',
        type: 'Plutus::Asset',
        contra: nil
      )
    end
  end

  context '#Create' do
    it 'should have permitted params' do
      post :create

      expect_status 400
      expect_json(global_errors: "param is missing or the value is empty: asset")
    end

    it 'name should not be blank' do
      post :create, params: { asset: {fake: 'params'} }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"]})
    end

    it 'name should be unique' do
      create(:cash)
      post :create, params: { asset: { name: 'Cash' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should create an asset' do
      post :create, params: { asset: { name: 'Cash' } }

      expect_status 200
      expect_json(
        id: Plutus::Asset.first.id,
        name: 'Cash',
        type: 'Plutus::Asset',
        contra: nil
      )
    end
  end

  context '#Update' do
    before { @asset = create(:cash) }

    it 'name should not be blank' do
      put :update, params: { id: @asset.id, asset: { name: '' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["can't be blank"] })
    end

    it 'name should be unique' do
      create(:assets, name: 'another cash')
      put :update, params: { id: @asset.id, asset: { name: 'another cash' } }

      expect_status :unprocessable_entity
      expect_json(errors: { name: ["has already been taken"] })
    end

    it 'should update record' do
      put :update, params: { id: @asset.id, asset: { name: 'updated' } }

      expect_json(
        id: @asset.id,
        name: 'updated'
      )
    end
  end
end
