module ApplicationHelper
  def fix_url(link)
    if link.starts_with?('http://') || link.starts_with?('http://')
      link
    else
      "http://#{link}"
    end
  end

  def display_datetime(datetime)
    datetime.strftime("%m/%d/%Y at %l:%M%P %Z")
  end

end
