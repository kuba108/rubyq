module MenusHelper

  def menu(name, language)
    menu = Menu.find_by(name: name, language: language)
    if menu.present?
      raw menu.content
    else
      ""
    end
  end

end
