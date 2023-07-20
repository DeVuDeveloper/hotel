require 'rails_helper'
require 'rails_helper'

RSpec.describe Hotel, type: :model do
  it 'is valid with valid attributes' do
    hotel = FactoryBot.build(:hotel)
    expect(hotel).to be_valid
  end

  it 'is not valid without a name' do
    hotel = FactoryBot.build(:hotel, name: nil)
    expect(hotel).to_not be_valid
  end

  it 'is not valid without an address' do
    hotel = FactoryBot.build(:hotel, address: nil)
    expect(hotel).to_not be_valid
  end

  it 'is not valid without a description' do
    hotel = FactoryBot.build(:hotel, description: nil)
    expect(hotel).to_not be_valid
  end

  it 'is not valid without a contact' do
    hotel = FactoryBot.build(:hotel, contact: nil)
    expect(hotel).to_not be_valid
  end
end
