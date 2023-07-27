require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is not valid with a duplicate email" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    expect(user).not_to be_valid
  end

  it "is valid with a unique email" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "another@example.com")
    expect(user).to be_valid
  end

  it "is valid with a valid role" do
    user = build(:user, role: :user)
    expect(user).to be_valid
  end

  it "is not valid with an invalid role" do
    expect {
      build(:user, role: :invalid_role)
    }.to raise_error(ArgumentError)
  end

  it "has the correct default role" do
    user = create(:user)
    expect(user.role).to eq("super_admin")
  end
end
