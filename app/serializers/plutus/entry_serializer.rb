class Plutus::EntrySerializer < ActiveModel::Serializer
  attributes :id, :description, :date

  has_many :debits, serializer: DebitSerializer, namespace: Plutus
  has_many :credits, serializer: CreditSerializer, namespace: Plutus
end
