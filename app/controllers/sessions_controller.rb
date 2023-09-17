class SessionsController < Devise::SessionsController
  def create
    super
    expire_action(controller: 'home', action: 'index')
  end

  def destroy
    super
    expire_action(controller: 'home', action: 'index')
  end
end

