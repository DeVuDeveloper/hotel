require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room) }
  let(:reservation) { FactoryBot.create(:reservation, user: user, room: room) }

  before do
    user
    room
    reservation
  end

  it 'is valid with valid attributes' do
    payment = FactoryBot.build(:payment, user: user, reservation: reservation)
    expect(payment).to be_valid
  end

  it 'is not valid with a negative amount' do
    payment = FactoryBot.build(:payment, user: user, reservation: reservation, amount: -100)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a payment_date' do
    payment = FactoryBot.build(:payment, user: user, reservation: reservation, payment_date: nil)
    expect(payment).to_not be_valid
  end

  it 'is not valid without a payment_status' do
    payment = FactoryBot.build(:payment, user: user, reservation: reservation, payment_status: nil)
    expect(payment).to_not be_valid
  end
end

