FactoryGirl.define do
  factory :equity, class: 'Plutus::Equity', aliases: [:drawing] do
    name 'Drawing'
    contra true
  end
end
