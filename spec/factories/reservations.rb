# spec/factories/reservations.rb
FactoryBot.define do
  factory :reservation do
    start_date { Date.today }
    end_date { 1.week.from_now }
    number_of_guests { 2 }
    total_price { 100 }
    status { "Confirmed" }
    association :user
    association :room
  end
end
