class Plutus::AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :contra, :debits_balance, :credits_balance

  def trial_balance
    object.class.trial_balance
  end

  has_many :credit_amounts, namespace: Plutus
  has_many :debit_amounts, namespace: Plutus
  has_many :entries, namespace: Plutus
end
