require 'rails_helper'

RSpec.describe Amenity, type: :model do
  it 'is valid with valid attributes' do
    hotel = FactoryBot.create(:hotel)
    amenity = FactoryBot.build(:amenity, hotel: hotel)
    expect(amenity).to be_valid
  end

  it 'is not valid without a name' do
    hotel = FactoryBot.create(:hotel)
    amenity = FactoryBot.build(:amenity, hotel: hotel, name: nil)
    expect(amenity).to_not be_valid
  end
end
