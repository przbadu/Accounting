FactoryGirl.define do
  factory :liability, class: 'Plutus::Account', aliases: [:unearned_revenue] do
    name 'Unearned revenue'
    type 'Plutus::Liability'
  end
end
