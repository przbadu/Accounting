FactoryGirl.define do
  factory :liability, class: 'Plutus::Account', aliases: [:unearned_revenue] do
    name 'Unearned revenue'
  end
end
