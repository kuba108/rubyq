class Admin::WrappersController < Admin::BaseController

  def create
    wrapper = Wrapper.create(wrapper_params)
    section = wrapper.section

    render json: {
      result: 'success',
      msg: "Widget byl přidán.",
      redirect_path: admin_page_sections_path(page_id: section.page_id)
    }
  end

  def update
    wrapper = Wrapper.find(params[:id])
    if wrapper.update_attributes(wrapper_params)
      if request.xhr?
        render json: {
          result: 'success',
          msg: "Wrapper byl ulozen."
        }
      else
        flash[:notice] = "Wrapper byl ulozen."
        redirect_to admin_page_sections_path(page_id: params[:page_id])
      end
    else
      if request.xhr?
        render json: {
          result: 'error',
          msg: "Wrapper nebyl ulozen, nastala chyba."
        }, status: 422
      else
        flash[:error] = "Wrapper nebyl ulozen, nastala chyba."
        redirect_to admin_page_sections_path(page_id: params[:page_id])
      end
    end
  end

  def destroy
    wrapper = Wrapper.find(params[:id])
    section = wrapper.section
    wrapper.destroy!

    render json: {
      result: 'success',
      msg: "Wrapper byl smazán.",
      redirect_path: admin_page_sections_path(page_id: section.page_id)
    }
  rescue
    render json: {
      result: 'error',
      msg: "Wrapper nebyl smazán, nastala chyba.",
      redirect_path: admin_page_sections_path(page_id: section.page_id)
    }, status: 422
  end

  private

  def wrapper_params
    params.require(:wrapper).permit(:section_id, :name, :description, :position, css_classes: [])
  end

end
