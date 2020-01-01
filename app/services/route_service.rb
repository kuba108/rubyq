class RouteService

  attr_reader :error_type
  attr_reader :redirect_permalink

  def find_by_permalink(permalink)
    if permalink.present?
      route = Route.find_by(permalink: permalink)
      if route.present?
        if route.route_type == 'redirect'
          @error_type = 'redirection'
          @redirect_permalink = route.routable.route.permalink
          return nil
        end

        klass = "#{route.routable_type.camelcase}".split('::').inject(Object) { |o,c| o.const_get c }
        klass.find(route.routable_id)
      else
        return false
      end
    else
      page = Page.home_page
      raise "Page not found!" if page.blank?
      page
    end
  rescue
    Page.all.first
  end

end