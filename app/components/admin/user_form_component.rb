class Admin::UserFormComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end
end
