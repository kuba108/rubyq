class PagesController < ApplicationController

  def show
    permalink = params[:permalink]
    route_service = RouteService.new
    @page = route_service.find_by_permalink(permalink)

    # Redirects to 404 when page is not found.
    unless @page
      if route_service.error_type == 'redirection'
        redirect_to '/' + route_service.redirect_permalink, status: 301
        return
      else
        not_found
      end
    end

    set_locale(@page.language)

    respond_to do |format|
      format.html do
        begin
          render action: @page.layout.to_sym
        rescue ActionView::MissingTemplate
          render action: 'default'
        end
      end
    end
  end

end
