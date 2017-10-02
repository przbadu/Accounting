# Assets
['Accounts receivable', 'Cash'].each do |asset|
  Plutus::Asset.find_or_create_by name: asset
end

# Liability
['Income tax payable'].each do |liability|
  Plutus::Liability.find_or_create_by name: liability
end

# Revenue
['Interest received', 'Sales'].each do |revenue|
  Plutus::Revenue.find_or_create_by name: revenue
end

# Expenses
[
  'Accounting fees',
  'Advertising and promotion',
  'Bank charges',
  'Computer equipment',
  'Donations',
  'Electricity',
  'Entertainment',
  'Legal fees',
  'Motor vehicle expenses',
  'Printing and stationery',
  'Rent',
  'Repairs and maintenance',
  'Telephone'
].each do |expense|
  Plutus::Expense.find_or_create_by name: expense
end

# Equity (with contra true)
Plutus::Equity.create name: 'Drawing', contra: true
