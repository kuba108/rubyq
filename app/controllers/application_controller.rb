class ApplicationController < ActionController::Base

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def set_locale(locale)
    I18n.locale = locale.present? ? locale.to_sym : :cs
  end

end
