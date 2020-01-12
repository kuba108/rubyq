class Admin::MenuItemsController < Admin::BaseController

  def create
    authorize MenuItem
    if params[:menu_item][:page_id].present?
      page = Page.find(params[:menu_item][:page_id])
      item = MenuItem.create!(menu_item_params.merge({ page_id: page.id, url: page.route.permalink, position: (Page.all.count + 1) }))
    else
      item = MenuItem.create!(menu_item_params.merge({ position: (Page.all.count + 1) }))
    end
    render json: {
      result: 'success',
      msg: "Položka menu #{item.label} byla přidána.",
      redirect_path: admin_menu_path(id: menu_item_params[:menu_id])
    }
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue StandardError => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      result: 'error',
      msg: "Položka menu nebyla přidána.",
      redirect_path: admin_menus_path(id: menu_item_params[:menu_id])
    }, status: 422
  end

  def update
    authorize MenuItem
    menu_item = MenuItem.find(params[:id])
    if params[:menu_item][:page_id].present?
      page = Page.find(params[:menu_item][:page_id])
      menu_item.update_attributes(menu_item_params.merge({ page_id: page.id, url: page.route.permalink }))
    else
      menu_item.update_attributes(menu_item_params)
    end
    render json: {
      result: 'success',
      msg: "Položka menu #{menu_item.label} byla uložena.",
      redirect_path: admin_menu_path(id: menu_item.menu.id)
    }
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue StandardError => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      result: 'error',
      msg: "Položka menu #{menu_item.label} nebyla uložena.",
      redirect_path: admin_menu_path(id: menu_item.menu.id)
    }, status: 422
  end

  def destroy
    item = MenuItem.find(params[:id])
    menu = item.menu
    authorize item
    label = item.label
    menu_name = menu.name
    if item.destroy
      render json: {
        result: 'success',
        msg: "Položka menu #{label} byla smazána.",
        redirect_path: admin_menu_path(id: menu.id)
      }
    else
      render json: {
        result: 'error',
        msg: "Položka menu #{label} nebyla smazána.",
        redirect_path: admin_menu_path(id: menu.id)
      }, status: 422
    end
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue
    render json: {
      result: 'error',
      msg: "Položka menu #{label} nebyla smazána.",
      redirect_path: menu.present? ? admin_menu_path(id: menu.id) : admin_menus_path
    }, status: 422
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:menu_id, :label, :url, :position, :kind, :new_window)
  end

end
