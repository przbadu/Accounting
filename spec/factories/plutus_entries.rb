FactoryGirl.define do
  factory :entry, class: 'Plutus::Entry' do
    description 'Order placed for widgets'
    date { Date.parse('2nd Oct 2017') }
  end
end
