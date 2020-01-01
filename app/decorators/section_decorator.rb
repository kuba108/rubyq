class SectionDecorator < Draper::Decorator

  delegate_all

  def render_wrappers(page, section)
    html = ""
    wrappers = object.wrappers.order(position: :asc)
    if wrappers.present?
      wrappers.each do |wrapper|
        html += wrapper.decorate.html(page, section)
      end
    end
    html
  end

  def html(page)
    h.render template: "admin/sections/html/#{object.name}.html", locals: { page: page, section: object }
  end

end
