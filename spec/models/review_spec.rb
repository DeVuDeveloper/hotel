require "rails_helper"

RSpec.describe Review, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:hotel) { FactoryBot.create(:hotel) }

  it "is valid with valid attributes" do
    review = FactoryBot.build(:review, user: user, hotel: hotel)
    expect(review).to be_valid
  end

  it "is not valid without a rating" do
    review = FactoryBot.build(:review, rating: nil)
    expect(review).to_not be_valid
  end

  it "is not valid with a rating less than 1" do
    review = FactoryBot.build(:review, rating: 0)
    expect(review).to_not be_valid
  end

  it "is not valid with a rating greater than 5" do
    review = FactoryBot.build(:review, rating: 6)
    expect(review).to_not be_valid
  end

  it "is not valid without a comment" do
    review = FactoryBot.build(:review, comment: nil)
    expect(review).to_not be_valid
  end
end
