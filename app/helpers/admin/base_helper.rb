module Admin::BaseHelper

  def active_sidebar_item(controller_name)
    params[:controller] == "admin/#{controller_name}" ? "active" : ""
  end

  def time_to_string(time, format = :long)
    if time && time.is_a?(Time)
      I18n.l(time, format: format)
    else
      "Žádné datum"
    end
  end

  def date_to_string(date, format = :date)
    if date && date.is_a?(Time)
      I18n.l(date, format: format)
    else
      "Žádné datum"
    end
  end

  def title(title)
    content_for(:title) { title }
  end

  def breadcrumbs(items)
    items.insert 0, { label: '<span class="fa fa-home"></span>'.html_safe, path: admin_dashboard_path, class: 'home' }
    content_for(:breadcrumbs) { raw items.map{|i| link_to i[:label], i[:path], class: i[:class]}.join(' / ') }
  end

end
