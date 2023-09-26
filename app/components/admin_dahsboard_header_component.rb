# frozen_string_literal: true

class AdminDahsboardHeaderComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end
end
