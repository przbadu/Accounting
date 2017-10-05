FactoryGirl.define do
  factory :revenue, class: 'Plutus::Revenue', aliases: [:sales] do
    name 'Sales'
  end
end
