# frozen_string_literal: true

require "rails_helper"

RSpec.describe "notification_messages/show", type: :view do
  before(:each) do
    assign(:notification_message, NotificationMessage.create!(
      content: "MyText",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
