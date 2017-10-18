module ApplicationHelper
  def bootstrap_classes(key)
    case key
    when :alert, :danger
      "alert alert-danger"
    when :success, :notice
      "alert alert-success"
    when :warning
      "alert alert-warning"
    else
      "alert alert-info"
    end
  end
end
