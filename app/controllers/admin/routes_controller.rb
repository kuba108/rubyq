class Admin::RoutesController < Admin::BaseController

  def update
    route = Route.find(params[:id])
    new_permalink = params[:route][:permalink].parameterize

    service = ChangeRouteService.new(route, new_permalink)
    service.change_route

    render json: {
      result: 'success',
      msg: "Odkaz byl změněn na adresu #{new_permalink}.",
      redirect_path: admin_page_path(id: route.routable_id)
    }
  rescue
    render json: {
      result: 'error',
      msg: service.present? && service.errors.any? ? service.errors.first : "Odkaz s adresou nebyl změněn.",
      redirect_path: admin_page_path(id: route.routable_id)
    }, status: 422
  end

  def destroy
    route = Route.find(params[:id])
    routable_id = route.routable_id
    permalink = route.permalink
    raise "Route cannot be destroyed!" if route.route_type == 'standard'
    route.destroy!

    render json: {
      result: 'success',
      msg: "Odkaz s adresou #{permalink} byl smazán.",
      redirect_path: admin_page_path(id: routable_id)
    }
  rescue
    render json: {
      result: 'error',
      msg: "Odkaz s adresou #{permalink} nebyl smazán.",
      redirect_path: admin_page_path(id: routable_id)
    }, status: 422
  end

end
