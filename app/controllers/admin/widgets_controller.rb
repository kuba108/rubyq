class Admin::WidgetsController < Admin::BaseController

  def index
    @widgets = Widget.all
  end

  def create
    json_template = render_to_string action: "json/#{wrapper_params[:name]}.json", layouts: false, locals: { params: { json: {} } }
    widget = Widget.create(widget_params.merge({ json: json_template }))

    render json: {
      result: 'success',
      msg: "Widget byl přidán."
    }
  end

  def update
    widget = Widget.find(params[:id])
    json_template = render_to_string template: "admin/widgets/json/#{widget.name}.json", locals: { params: params[:widget] }

    if widget.update_attributes(widget_params.merge({ json: json_template }))
      update_service = WidgetUpdateService.new(widget)
      update_service.perform
      if request.xhr?
        render json: {
          result: 'success',
          msg: "Widget byl ulozen."
        }
      else
        flash[:notice] = "Widget byl ulozen."
        redirect_to admin_page_sections_path(page_id: params[:widget][:page_id])
      end
    else
      if request.xhr?
        render json: {
          result: 'error',
          msg: "Widget nebyl ulozen, nastala chyba."
        }, status: 422
      else
        flash[:error] = "Widget nebyl ulozen, nastala chyba."
        redirect_to admin_page_sections_path(page_id: params[:widget][:page_id])
      end
    end
  end

  def destroy
    widget = Widget.find(params[:id])
    name = widget.name
    widget.destroy!
    render json: {
      result: 'success',
      msg: "Widget #{name} byl smazán."
    }
  rescue
    render json: {
      result: 'error',
      msg: "Widget nebyl smazán, nastala chyba."
    }, status: 422
  end

  private

  def widget_params
    params.require(:widget).permit(:name, :description, :global, :status, attachments: [])
  end

end
