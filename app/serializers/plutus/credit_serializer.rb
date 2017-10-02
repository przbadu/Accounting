class Plutus::CreditSerializer < ActiveModel::Serializer
  attributes :id, :account_name, :amount

  belongs_to :entry, serializer: EntrySerializer, namespace: Plutus
end
