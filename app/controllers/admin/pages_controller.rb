class Admin::PagesController < Admin::BaseController

  def index
    authorize Page
    @search = Page.all.order(created_at: :desc).ransack(params[:q])
    @pages = @search.result.paginate(page: page_number, per_page: per_page)
  end

  def show
    @page = Page.find(params[:id])
    authorize @page
  end

  def new
    @page = Page.new
    @parent_page = Page.find(params[:parent_id]) if params[:parent_id].present?
    authorize @page
  end

  def create
    authorize Page
    parent_page = Page.find_by(id: params[:page][:parent_id])
    page = Page.create!(page_params.merge({ uuid: parent_page.present? ? parent_page.uuid : SecureRandom.uuid, admin_user_id: current_admin_user.id, publish_type: 'public' }))
    Route.create! routable_id: page.id, routable_type: 'Page', permalink: params[:page][:route][:permalink]
    if parent_page.present?
      duplicate_service = DuplicatePageModelsService.new(parent_page, page)
      duplicate_service.duplicate_models
    end
    redirect_to action: :index
  end

  def update
    page = Page.find(params[:id])
    authorize page
    if params[:comp_id] == 'page-data'
      page.data = JSON.parse(page_params[:data])
    else
      page.update_attributes(page_params)
    end
    page.save!
    render json: {
      result: 'success'
    }.merge(component_render(params, page_params))
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue => e
    render Controller::Responder.unknown_error(e).merge(component_render(params, page_params)), status: 422
  end

  def destroy
    page = Page.find(params[:id])
    authorize page
    title = page.title
    page.destroy!
    render json: {
      result: 'success',
      msg: "Stránka #{title} byla smazána.",
      redirect_path: admin_pages_path
    }
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue
    render json: {
      result: 'error',
      msg: "Stránka #{title} nebyla smazána.",
      redirect_path: admin_pages_path
    }, status: 422
  end

  # Updates page wrappers order.
  def update_sections_order
    items = params[:data][:items]

    i = 1
    items.each do |id|
      item = Section.find(id)
      item.position = i
      item.save!
      i += 1
    end

    render json: {
      result: 'success',
      msg: "Změny jsou uloženy :)"
    }
  end

  def update_wrappers_order
    items = params[:data][:items]

    i = 1
    items.each do |id|
      item = Wrapper.find(id)
      item.section_id = params[:data][:sectionId]
      item.position = i
      item.save!
      i += 1
    end

    render json: {
      result: 'success',
      msg: "Změny jsou uloženy :)"
    }
  end

  def update_wrapper_widgets
    #wrapper_widget = WrapperWidget.find(params[:data][:wrapperId])
    items = params[:data][:items]

    i = 1
    items.each do |id|
      item = WrapperWidget.find(id)
      item.wrapper_id = params[:data][:wrapperId]
      item.part = params[:data][:wrapperPart]
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

  def page_params
    params.require(:page).permit(:title, :uuid, :language, :layout, :admin_user_id, :content, :meta_title, :meta_description, :meta_keywords, :og_title, :og_description, :og_image, :state, :publish_type)
  end

  def page_number
    params[:page].to_i > 0 ? params[:page].to_i : 1
  end

  def per_page
    params[:per_page].to_i > 0 ? params[:per_page].to_i : 100
  end

end
