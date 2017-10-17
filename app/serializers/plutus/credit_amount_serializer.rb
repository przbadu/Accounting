class Plutus::CreditAmountSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount, :entry_id, :account_id

  belongs_to :entry, namespace: Plutus
  belongs_to :account, namespace: Plutus
end
