require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'is valid with valid attributes' do
    hotel = FactoryBot.create(:hotel)
    activity = FactoryBot.build(:activity, hotel: hotel)
    expect(activity).to be_valid
  end

  it 'is not valid without a name' do
    hotel = FactoryBot.create(:hotel)
    activity = FactoryBot.build(:activity, hotel: hotel, name: nil)
    expect(activity).to_not be_valid
  end

  it 'is not valid without a description' do
    hotel = FactoryBot.create(:hotel)
    activity = FactoryBot.build(:activity, hotel: hotel, description: nil)
    expect(activity).to_not be_valid
  end
end
