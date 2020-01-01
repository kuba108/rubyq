class Admin::SettingsController < Admin::BaseController

  def index
    @settings = {}
    Setting.all.each do |setting|
      @settings[setting.name] = setting
    end
  end

  def update
    setting = Setting.find(params[:id])
    setting.update_attributes(setting_params)
    render json: {
      result: 'success',
      msg: 'Nastavení bylo uloženo.',
      redirect_path: admin_settings_path
    }.merge(component_render(params, setting_params))
  rescue StandardError => e
    render json: {
      result: 'error',
      msg: "Nastavení nebylo uloženo.",
      redirect_path: admin_settings_path
    }.merge(component_render(params, setting_params)), status: 422
  end

  def create
    Setting.create!(setting_params)
    render json: {
      result: 'success',
      msg: 'Nastavení bylo uloženo.',
      redirect_path: admin_settings_path
    }.merge(component_render(params, setting_params))
  rescue StandardError => e
    render json: {
      result: 'error',
      msg: "Nastavení nebylo uloženo.",
      redirect_path: admin_settings_path
    }.merge(component_render(params, setting_params)), status: 422
  end

  def set_home_page
    page = Page.find(params[:page_id])
    page.home_page = true
    page.save!

    Page.where.not(id: params[:page_id]).update_all(home_page: false)

    render json: {
      result: 'success',
      msg: "Úvodní stránka byla nastavena.",
      redirect_path: admin_settings_path
    }
  rescue StandardError => e
    render json: {
      result: 'error',
      msg: "Nastavení nebylo uloženo.",
      redirect_path: admin_settings_path
    }, status: 422
  end

  private

  def setting_params
    params.require(:setting).permit(:name, :value, :value_type)
  end

end
