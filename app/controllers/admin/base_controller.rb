class Admin::BaseController < ActionController::Base

  include Pundit

  before_action :set_locale
  before_action :authenticate_admin_user!
  layout "admin/layouts/application"

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from 'StandardError' do |exception|
    raise exception unless request.xhr?
    Rails.logger.error exception.message
    Rails.logger.error exception.backtrace.join("\n")
    render text: "<pre>#{exception.class.name} - #{ERB::Util.html_escape(exception.message)}<br />#{exception.backtrace.join("<br />")}</pre>", status: 422
  end

  def pundit_user
    current_admin_user
  end

  def user_not_authorized
    flash[:alert] = "Pro tuto operaci nemáte oprávnění."
    redirect_to(request.referrer || admin_dashboard_path)
  end

  # Renders component
  def component_render(params, data)
    type = params[:type]
    component = params[:comp_id]
    i18n_scope = params[:i18n_scope]
    value = data.values.first
    { source: type, comp_id: component, text: format_value(type, value, i18n_scope) }
  end

  private

  # Formats value for label.
  #
  # For example sometimes in DB column is '0', but we want it to be return as 'no'.
  def format_value(type, value, i18n_scope)
    case type
    when 'select_editor'
      I18n.t(value, scope: i18n_scope)
    else
      value
    end
  end

  def number_to_boolean(value)
    value
  end

  def set_locale
    I18n.locale = current_admin_user.locale.to_sym
  rescue StandardError => e
    I18n.locale = I18n.default_locale
  end

end
