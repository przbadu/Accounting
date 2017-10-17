FactoryGirl.define do
  factory :expense, class: 'Plutus::Expense', aliases: [:salary] do
    name 'Salary'
  end
end
