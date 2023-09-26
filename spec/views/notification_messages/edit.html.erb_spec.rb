# frozen_string_literal: true

require "rails_helper"

RSpec.describe "notification_messages/edit", type: :view do
  let(:notification_message) do
    NotificationMessage.create!(
      content: "MyText",
      user: nil
    )
  end

  before(:each) do
    assign(:notification_message, notification_message)
  end

  it "renders the edit notification_message form" do
    render

    assert_select "form[action=?][method=?]", notification_message_path(notification_message), "post" do
      assert_select "textarea[name=?]", "notification_message[content]"

      assert_select "input[name=?]", "notification_message[user_id]"
    end
  end
end
