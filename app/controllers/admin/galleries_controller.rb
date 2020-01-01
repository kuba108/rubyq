class Admin::GalleriesController < Admin::BaseController

  def index
    authorize Gallery
    @search = Gallery.all.order(created_at: :desc).ransack(params[:q])
    @galleries = @search.result.paginate(page: page_number, per_page: per_page)
  end

  def show
    @gallery = Gallery.find(params[:id])
    authorize @gallery
  end

  def new
    @gallery = Gallery.new
    authorize @gallery
  end

  def create
    authorize Gallery
    Gallery.create!(gallery_params.merge({ admin_user_id: current_admin_user.id }))
    redirect_to action: :index
  end

  def update
    gallery = Gallery.find(params[:id])
    authorize gallery
    gallery.update_attributes(gallery_params)
    render json: {
      result: 'success'
    }.merge(component_render(params, gallery_params))
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue => e
    render Controller::Responder.unknown_error(e).merge(component_render(params, gallery_params)), status: 422
  end

  def destroy
    gallery = Gallery.find(params[:id])
    authorize gallery
    name = gallery.name
    gallery.destroy!
    render json: {
      result: 'success',
      msg: "Galerie #{name} byla smazána.",
      redirect_path: admin_galleries_path
    }
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue
    render json: {
      result: 'error',
      msg: "Galerie #{name} nebyla smazána.",
      redirect_path: admin_galleries_path
    }, status: 422
  end

  def update_gallery_items_order
    items = params[:data][:items]

    i = 1
    items.each do |id|
      item = GalleryItem.find(id)
      item.position = i
      item.save!
      i += 1
    end

    render json: {
      result: 'success',
      msg: "Změny jsou uloženy :)"
    }
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name, :description)
  end

  def page_number
    params[:page].to_i > 0 ? params[:page].to_i : 1
  end

  def per_page
    params[:per_page].to_i > 0 ? params[:per_page].to_i : 100
  end

end
