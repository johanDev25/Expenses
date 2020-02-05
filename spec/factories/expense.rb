FactoryBot.define do
  factory :expense do
    concept { "My test concept" }
    date_transaction { Date.current }
    amount { 99.5 }
    category
    type
  end
end
