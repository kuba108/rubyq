class Admin::MenusController < Admin::BaseController

  def index
    authorize Menu
    @menus = Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
    authorize @menu
  end

  def new
    @menu = Menu.new
    authorize @menu
  end

  def create
    authorize Menu
    if Menu.where(name: menu_params[:name], language: menu_params[:language]).any?
      raise RecordAlreadyExistsError.new("Menu with same name and language already exists.")
    end
    parent_menu = Menu.find_by(name: menu_params[:name], language: 'cs')
    menu = Menu.create!(menu_params.merge({ uuid: parent_menu.present? ? parent_menu.uuid : SecureRandom.uuid }))
    if parent_menu.present?
      duplicate_service = Menu::DuplicateService.new(parent_menu, menu)
      duplicate_service.duplicate_menu
    end
    redirect_to action: :index
  rescue RecordAlreadyExistsError => e
    flash[:error] = "Menu stejného typu pro jazyk #{I18n.t(menu_params[:language], scope: 'language')} již existuje. Pokud jej chcete nahradit, nejprve menu smažte."
    redirect_to action: :index
  rescue StandardError => e
    flash[:error] = "Při vytváření menu se něco nepovedlo."
    redirect_to action: :index
  end

  def destroy
    menu = Menu.find(params[:id])
    authorize menu
    name = menu.name
    menu.destroy!
    render json: {
      result: 'success',
      msg: "Menu #{name} bylo smazáno.",
      redirect_path: admin_menus_path
    }
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue
    render json: {
      result: 'error',
      msg: "Menu #{name} nebylo smazáno.",
      redirect_path: admin_menus_path
    }, status: 422
  end

  def update
    authorize Menu, :change_order?
    service = MenuTreeService.new
    menu = Menu.find(params[:id])
    json = JSON.parse(params[:data])[0]

    json.each_with_index do |item, i|
      service.change_item(item, i)
    end

    menu.cache_html

    render json: {
      result: 'success',
      msg: "Změny v menu #{menu.name} byly uloženy.",
      redirect_path: admin_menu_path(id: menu.id)
    }
  rescue StandardError => e
    render json: {
      result: 'error',
      msg: "Neco se nepovedlo.",
      redirect_path: menu.present? ? admin_menu_path(id: menu.id) : admin_menus_path
    }, status: 422
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :uuid, :language, :layout, :content)
  end

end
