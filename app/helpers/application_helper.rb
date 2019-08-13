module ApplicationHelper
  def active_link_class(path)
    'active' if current_page?(path)
  end

  def active_link_to(body, url, html_options = {})
    html_options[:class] ||= []
    html_options[:class] = html_options[:class].split if html_options[:class].is_a?(String)
    html_options[:class] << active_link_class(url) if html_options[:class].is_a?(Array)
    link_to body, url, html_options
  end
end
