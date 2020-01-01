class PageDecorator < Draper::Decorator

  delegate_all

  def content
    html = ""
    sections.order(position: :asc).each do |section|
      html += section.decorate.html(object)
    end
    html
  end

end