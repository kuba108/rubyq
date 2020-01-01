class WidgetDecorator < Draper::Decorator

  delegate_all

  def html(page, section, wrapper)
    h.render template: "admin/widgets/html/#{object.name}.html", locals: { page: page, section: section, wrapper: wrapper, widget: object, json: JSON.parse(object.json) }
  end

end
