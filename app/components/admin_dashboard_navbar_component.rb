# frozen_string_literal: true

class AdminDashboardNavbarComponent < ViewComponent::Base
  def initialize(room:)
    @room = room
  end

  def active_link_to(path, options = {}, &block)
    is_active = current_page?(path)
    active_class = is_active ? options[:active_class] : ""
    is_active ? options[:hover_class] : options[:default_hover_class]

    link_to(path, options.merge(class: "#{options[:class]} #{active_class}"), &block)
  end
end
