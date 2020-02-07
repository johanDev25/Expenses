#Category.create([{ body: 'Fun' },
#  { body: 'Car' },
#  { body: 'Restaurants' },
#  { body: 'Education' },
#  { body: 'Services' },
#  { body: 'Travel' },
#  { body: 'Home' }])

#  Type.create([{ body: 'Purchase' },
#    { body: 'Withdrawal' },
#    { body: 'Transfer'},
#    { body: 'Payment'}])

    300.times do
      Expense.create([{
        concept: Faker::Commerce.product_name,
        amount: Faker::Number.between(from: 10, to: 20000),
        date: Faker::Date.between(from: 6.month.ago, to: Date.today),
        category_id: Faker::Number.between(from: 1, to: 7),
        type_id: Faker::Number.between(from: 1, to: 4)
        }])
      end
