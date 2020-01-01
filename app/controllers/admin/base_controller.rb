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
    value = data[:value]
    { source: type, comp_id: component, value: format_value(type, value) }
  end

  private

  # Formats value for label.
  #
  # For example sometimes in DB column is '0', but we want it to be return as 'no'.
  def format_value(type, value)
    case type
    when 'check_box_editor'
      value
    else
      value
    end
  end

  def number_to_boolean(value)
    value
  end

  def set_locale
    I18n.locale = :cs
  end

end
