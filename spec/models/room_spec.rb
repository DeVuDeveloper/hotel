require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @hotel = FactoryBot.create(:hotel)
  end

  it 'is valid with valid attributes' do
    room = FactoryBot.build(:room, hotel: @hotel)
    expect(room).to be_valid
  end

  it 'is not valid without a name' do
    room = FactoryBot.build(:room, name: nil, hotel: @hotel)
    expect(room).to_not be_valid
  end

  it 'is not valid without a room_type' do
    room = FactoryBot.build(:room, room_type: nil, hotel: @hotel)
    expect(room).to_not be_valid
  end

  it 'is not valid with a negative price_per_night' do
    room = FactoryBot.build(:room, price_per_night: -100, hotel: @hotel)
    expect(room).to_not be_valid
  end
end

