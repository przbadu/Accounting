FactoryGirl.define do
  factory :liability, class: 'Plutus::Liability', aliases: [:unearned_revenue] do
    name 'Unearned revenue'
  end
end
