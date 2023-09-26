# frozen_string_literal: true

module Admin
  class UserFormComponent < ViewComponent::Base
    def initialize(user:)
      @user = user
    end
  end
end
