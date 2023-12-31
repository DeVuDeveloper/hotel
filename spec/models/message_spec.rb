# frozen_string_literal: true

require "rails_helper"

RSpec.describe Message, type: :model do
  let(:hotel) { FactoryBot.create(:hotel) }

  before do
    hotel
  end

  it "is valid with valid attributes" do
    message = FactoryBot.build(:message, hotel:)
    expect(message).to be_valid
  end

  it "is not valid without a name" do
    message = FactoryBot.build(:message, hotel:, name: nil)
    expect(message).to_not be_valid
  end

  it "is not valid without a valid email" do
    message = FactoryBot.build(:message, hotel:, email: "invalid_email")
    expect(message).to_not be_valid
  end

  it "is not valid without content" do
    message = FactoryBot.build(:message, hotel:, content: nil)
    expect(message).to_not be_valid
  end
end
