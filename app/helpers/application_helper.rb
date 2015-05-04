module ApplicationHelper
  def fix_url(link)
    if link.starts_with?('http://') || link.starts_with?('http://')
      link
    else
      "http://#{link}"
    end
  end

  def display_datetime(datetime)
    if logged_in? && !current_user.time_zone.blank?
      datetime = datetime.in_time_zone(current_user.time_zone)
    else
    datetime.strftime("%m/%d/%Y at %l:%M%P %Z")
    end

  end

end
