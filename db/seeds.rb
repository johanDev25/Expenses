Category.create([{ body: 'Fun' },
               { body: 'Car' },
               { body: 'Restaurants' },
               { body: 'Education' },
               { body: 'Services' },
               { body: 'Travel' },
               { body: 'Home' }])

Type.create([{ body: 'Purchase' },
             { body: 'Withdrawal' },
             { body: 'Transfer'},
             { body: 'Payment'}])

(4.months.ago.to_date..Date.current).each do |date|
rand(6).times do
  Expense.create!(date: date, concept: Faker::Commerce.product_name , amount: Faker::Number.between(10,900) ,
                  category_id: Faker::Number.between(1 ,7) , type_id: Faker::Number.between(1 ,4) )
end
end
