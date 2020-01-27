# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
