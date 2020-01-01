class WrapperDecorator < Draper::Decorator

  delegate_all

  def render_part(page, section, part)
    html = ""
    wrapper_widgets = object.wrapper_widgets.where(part: part).order(position: :asc)
    if wrapper_widgets.present?
      wrapper_widgets.each do |item|
        html += item.widget.decorate.html(page, section, object)
      end
    end
    html
  end

  def html(page, section)
    h.render template: "admin/wrappers/html/#{object.name}.html", locals: { page: page, section: section, wrapper: object }
  end

end
