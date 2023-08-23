FactoryBot.define do
  factory :payment do
    amount { 100 }
    payment_date { Date.today }
    payment_status { "Paid" }
    association :user
    association :reservation
  end
end
