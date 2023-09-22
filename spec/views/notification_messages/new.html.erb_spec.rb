require 'rails_helper'

RSpec.describe "notification_messages/new", type: :view do
  before(:each) do
    assign(:notification_message, NotificationMessage.new(
      content: "MyText",
      user: nil
    ))
  end

  it "renders new notification_message form" do
    render

    assert_select "form[action=?][method=?]", notification_messages_path, "post" do

      assert_select "textarea[name=?]", "notification_message[content]"

      assert_select "input[name=?]", "notification_message[user_id]"
    end
  end
end
