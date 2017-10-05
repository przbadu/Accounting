FactoryGirl.define do
  factory :assets, class: 'Plutus::Asset', aliases: [:cash] do
    name 'Cash'
  end
end
