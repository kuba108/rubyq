class Admin::WrapperWidgetsController < Admin::BaseController

  def create
    wrapper = Wrapper.find(wrapper_widget_params[:wrapper_id])
    json_template = render_to_string template: "/admin/widgets/json/#{params[:wrapper_widget][:widget_name]}.json", layouts: false, locals: { params: { json: {} } }
    widget = Widget.create(name: params[:wrapper_widget][:widget_name], json: json_template)
    wrapper_widget = WrapperWidget.create!(wrapper_widget_params.merge({ widget_id: widget.id }))

    render json: {
      result: 'success',
      msg: "Widget byl přidán.",
      redirect_path: admin_page_sections_path(page_id: wrapper.section.page_id)
    }
  end

  def destroy
    wrapper_widget = WrapperWidget.find(params[:id])
    name = wrapper_widget.widget.name
    page_id = wrapper_widget.wrapper.section.page_id

    if wrapper_widget.destroy
      render json: {
        result: 'success',
        msg: "Widget #{name} byl smazán.",
        redirect_path: admin_page_sections_path(page_id: page_id)
      }
    else
      render json: {
        result: 'error',
        msg: "Widget nebyl smazán, nastala chyba.",
        redirect_path: admin_page_sections_path(page_id: page_id)
      }, status: 422
    end
  end

  private

  def wrapper_widget_params
    params.require(:wrapper_widget).permit(:wrapper_id, :part, :position)
  end

end
