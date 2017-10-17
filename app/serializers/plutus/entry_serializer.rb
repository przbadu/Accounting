class Plutus::EntrySerializer < ActiveModel::Serializer
  attributes :id, :description, :date

  has_many :debit_amounts, namespace: Plutus
  has_many :credit_amounts, namespace: Plutus
end
