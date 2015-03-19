module ApplicationHelper
  def fix_url(link)
    if link.starts_with?('http://') || link.starts_with?('http://')
      link
    else
      "http://#{link}"
    end
  end
end
