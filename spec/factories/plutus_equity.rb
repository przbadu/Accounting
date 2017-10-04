FactoryGirl.define do
  factory :equity, class: 'Plutus::Equity', aliases: [:drawing] do
    name 'Drawing'
    type 'Plutus::Equity'
    contra true
  end
end
