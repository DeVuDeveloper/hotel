class Admin::UserEditFormComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end
end
