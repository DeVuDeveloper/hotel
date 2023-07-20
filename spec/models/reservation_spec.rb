require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'is valid with valid attributes' do
    reservation = FactoryBot.build(:reservation)
    expect(reservation).to be_valid
  end

  it 'is not valid without a start_date' do
    reservation = FactoryBot.build(:reservation, start_date: nil)
    expect(reservation).to_not be_valid
  end

  it 'is not valid without an end_date' do
    reservation = FactoryBot.build(:reservation, end_date: nil)
    expect(reservation).to_not be_valid
  end

  it 'is not valid with a negative number_of_guests' do
    reservation = FactoryBot.build(:reservation, number_of_guests: -2)
    expect(reservation).to_not be_valid
  end

  it 'is not valid with a negative total_price' do
    reservation = FactoryBot.build(:reservation, total_price: -100)
    expect(reservation).to_not be_valid
  end

  it 'is not valid without a status' do
    reservation = FactoryBot.build(:reservation, status: nil)
    expect(reservation).to_not be_valid
  end
end
