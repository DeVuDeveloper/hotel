# frozen_string_literal: true

require "rails_helper"

RSpec.describe "notification_messages/index", type: :view do
  before(:each) do
    assign(:notification_messages, [
      NotificationMessage.create!(
        content: "MyText",
        user: nil
      ),
      NotificationMessage.create!(
        content: "MyText",
        user: nil
      )
    ])
  end

  it "renders a list of notification_messages" do
    render
    cell_selector = (Rails::VERSION::STRING >= "7") ? "div>p" : "tr>td"
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
