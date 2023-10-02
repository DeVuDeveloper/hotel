# frozen_string_literal: true

module Admin
  class UserComponent < ViewComponent::Base
    def initialize(user:, current_user:)
      @user = user
      @current_user = current_user
    end
  end
end
