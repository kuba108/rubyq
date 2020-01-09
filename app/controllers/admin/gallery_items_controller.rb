class Admin::GalleryItemsController < Admin::BaseController

  def create
    gallery_item = GalleryItem.create!(gallery_item_params)
    redirect_to admin_gallery_path(id: gallery_item.gallery_id)
  end

  def update
    gallery_item = GalleryItem.find(params[:id])
    gallery_item.update(gallery_item_params)

    render json: {
      result: 'success',
      msg: 'Obrázek je uložen :)',
      redirect_path: admin_gallery_path(id: gallery_item.gallery_id)
    }
  rescue StandardError => e
    render json: {
      result: 'error',
      msg: 'Obrázek se nepodařilo uložit.',
      redirect_path: gallery_item.present? ? admin_gallery_path(id: gallery_item.gallery_id) : admin_galleries_path
    }, status: 422
  end

  def destroy
    gallery_item = GalleryItem.find(params[:id])
    gallery_id = gallery_item.gallery_id
    gallery_item.image.purge
    gallery_item.destroy!

    render json: {
      result: 'success',
      msg: 'Obrázek je pryč :)',
      redirect_path: admin_gallery_path(id: gallery_id)
    }
  rescue StandardError => e
    render json: {
      result: 'error',
      msg: 'Obrázek se nepodařilo smazat.',
      redirect_path: gallery_id.present? ? admin_gallery_path(id: gallery_id) : admin_galleries_path
    }, status: 422
  end

  private

  def gallery_item_params
    params.require(:gallery_item).permit(:gallery_id, :label, :description, :position, :image, label_i18n: {}, description_i18n: {})
  end

end
