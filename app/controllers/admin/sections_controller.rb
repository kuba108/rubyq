class Admin::SectionsController < Admin::BaseController

  def index
    @page = Page.find(params[:page_id])
  end

  def create
    section = Section.create(section_params)

    render json: {
      result: 'success',
      msg: "Sekce byla přidána.",
      redirect_path: admin_page_sections_path(page_id: section.page_id)
    }
  end

  def update
    section = Section.find(params[:id])
    if section_params['css_classes'].blank?
      custom_params = section_params.merge({'css_classes': []})
    else
      custom_params = section_params
    end
    if section.update_attributes(custom_params)
      if request.xhr?
        render json: {
          result: 'success',
          msg: "Sekce byla uložena."
        }
      else
        flash[:notice] = "Sekce byla uložena."
        redirect_to admin_section_path(page_id: params[:page_id], id: params[:section][:id])
      end
    else
      if request.xhr?
        render json: {
          result: 'error',
          msg: "Sekce nebyla uložena, nastala chyba."
        }, status: 422
      else
        flash[:error] = "Sekce nebyla uložena, nastala chyba."
        redirect_to admin_page_sections_path(page_id: params[:page_id])
      end
    end
  end

  def destroy
    section = Section.find(params[:id])
    page_id = section.page_id
    section.destroy!

    render json: {
      result: 'success',
      msg: "Sekce byla smazána.",
      redirect_path: admin_page_sections_path(page_id: page_id)
    }
  rescue
    render json: {
      result: 'error',
      msg: "Sekce nebyla smazána, nastala chyba.",
      redirect_path: admin_page_sections_path(page_id: page_id)
    }, status: 422
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :description, :position, css_classes: [])
  end

end
