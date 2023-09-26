# frozen_string_literal: true

require "rails_helper"

RSpec.describe Activity, type: :model do
  it "is valid with valid attributes" do
    hotel = FactoryBot.create(:hotel)
    activity = FactoryBot.build(:activity, hotel:)
    expect(activity).to be_valid
  end

  it "is not valid without a name" do
    hotel = FactoryBot.create(:hotel)
    activity = FactoryBot.build(:activity, hotel:, name: nil)
    expect(activity).to_not be_valid
  end

  it "is not valid without a description" do
    hotel = FactoryBot.create(:hotel)
    activity = FactoryBot.build(:activity, hotel:, description: nil)
    expect(activity).to_not be_valid
  end
end
