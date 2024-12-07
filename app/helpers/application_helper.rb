module ApplicationHelper
  def status_class(status)
    case status
    when "public"
      "bg-success text-white"
    when "private"
      "bg-primary text-white"
    when "archived"
      "bg-secondary text-white"
    when "draft"
      "bg-warning text-dark"
    else
      "bg-dark text-white"
    end
  end
end
