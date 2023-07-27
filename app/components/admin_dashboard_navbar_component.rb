class AdminDashboardNavbarComponent < ViewComponent::Base

  def active_link_to(path, options = {}, &block)
    is_active = current_page?(path)
    active_class = is_active ? options[:active_class] : ""
    is_active ? options[:hover_class] : options[:default_hover_class]

    link_to(path, options.merge(class: "#{options[:class]} #{active_class}")) do
      yield
    end
  end
end
