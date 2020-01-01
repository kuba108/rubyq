class MenuDecorator < Draper::Decorator

  delegate_all

  def content
    h.render template: "admin/menus/html/#{object.name}.html", locals: { menu_items: object.base_items }
  end

end