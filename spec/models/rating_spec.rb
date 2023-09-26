# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rating, type: :model do
  before do
    @hotel = FactoryBot.create(:hotel)
  end

  it "is valid with valid attributes" do
    rating = build(:rating, hotel: @hotel)
    expect(rating).to be_valid
  end

  it "is not valid with a negative average_rating" do
    rating = build(:rating, average_rating: -1, hotel: @hotel)
    expect(rating).to_not be_valid
  end

  it "is not valid with an average_rating greater than 5" do
    rating = build(:rating, average_rating: 6, hotel: @hotel)
    expect(rating).to_not be_valid
  end
end
