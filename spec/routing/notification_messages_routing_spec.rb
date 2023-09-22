require "rails_helper"

RSpec.describe NotificationMessagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/notification_messages").to route_to("notification_messages#index")
    end

    it "routes to #new" do
      expect(get: "/notification_messages/new").to route_to("notification_messages#new")
    end

    it "routes to #show" do
      expect(get: "/notification_messages/1").to route_to("notification_messages#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/notification_messages/1/edit").to route_to("notification_messages#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/notification_messages").to route_to("notification_messages#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/notification_messages/1").to route_to("notification_messages#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/notification_messages/1").to route_to("notification_messages#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/notification_messages/1").to route_to("notification_messages#destroy", id: "1")
    end
  end
end
