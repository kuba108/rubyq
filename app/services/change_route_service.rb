class ChangeRouteService

  attr_accessor :errors

  def initialize(route, new_permalink)
    @route = route
    @new_permalink = new_permalink
    @new_route = nil
    @errors = []
  end

  def change_route
    if @route.permalink == @new_permalink
      @errors << "Nový permalink je stejný jako aktuální. Permalinky nemohou být stejné."
      raise "Permalinks are same!"
    end

    check_other_resources
    check_permalinks
    # Returns route if route with same permalink will be found for same routable resource.
    @new_route = restore_route

    Route.transaction do
      # If new routes already exists, it means it was restored or created in previous blocks.
      unless @new_route.present?
        # Creates new route
        @new_route = Route.create! routable_id: @route.routable_id,
                                  routable_type: @route.routable_type,
                                  permalink: @new_permalink,
                                  route_type: 'standard'
      end

      # Changes route type of old route as redirect.
      @route.route_type = 'redirect'
      @route.save!

      # Finds all menu items @route old permalink and changes them into new permalink.
      MenuItem.where(url: @route.permalink, kind: 'page').each do |item|
        item.url = @new_permalink
        item.save!
      end
    end
  end

  private

  # Checks if any other existing routes has same permalink.
  def check_other_resources
    Route.where(permalink: @new_permalink).each do |route|
      if route.routable_id != @route.routable_id || route.routable_type == 'standard'
        @errors << "Nový permalink již existuje pro jiný odkaz. Nejprve upravte existující odkazy nebo zvolte jiný permalink."
        raise "Permalinks exists for another resource!"
      end
    end
  end

  # Checks if multiple routes exists for same resource.
  # If so, removes all of them except last one.
  def check_permalinks
    routes = Route.where(permalink: @new_permalink, routable_type: @route.routable_type, routable_id: @route.routable_id).order(created_at: :asc).to_a
    if routes.size > 1
      routes.pop
      routes.each do |route|
        route.destroy!
      end
    end
  end

  # If routes with required permalink exists and route was originally for same routable resource, restore route as standard.
  def restore_route
    route = Route.where(permalink: @new_permalink, routable_type: @route.routable_type, routable_id: @route.routable_id).first
    if route.present?
      route.route_type = 'standard'
      route.save!
    end
    route
  end

end