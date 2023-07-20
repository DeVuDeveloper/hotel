require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:room) { FactoryBot.create(:room, hotel: hotel) }

  before do
    room
  end

  it 'is valid with valid attributes' do
    calendar = FactoryBot.build(:calendar, room: room)
    expect(calendar).to be_valid
  end

  it 'is not valid without a date' do
    calendar = FactoryBot.build(:calendar, room: room, date: nil)
    expect(calendar).to_not be_valid
  end

  it 'is not valid with a negative price' do
    calendar = FactoryBot.build(:calendar, room: room, price: -100)
    expect(calendar).to_not be_valid
  end

  it 'is valid with available set to true or false' do
    calendar_true = FactoryBot.build(:calendar, room: room, available: true)
    calendar_false = FactoryBot.build(:calendar, room: room, available: false)
    expect(calendar_true).to be_valid
    expect(calendar_false).to be_valid
  end

  it 'is not valid with available set to nil' do
    calendar = FactoryBot.build(:calendar, room: room, available: nil)
    expect(calendar).to_not be_valid
  end
end
