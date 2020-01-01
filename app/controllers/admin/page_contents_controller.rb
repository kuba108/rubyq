class Admin::PageContentsController < Admin::BaseController

  def update
    page = Page.find(params[:id])
    page.content = page.decorate.content
    page.save!

    render json: {
      result: 'success',
      msg: 'Změny na stránce byly uloženy :)'
    }
  rescue StandardError => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      result: 'success',
      msg: "Změny na stránce nebyly uloženy.",
      redirect_path: admin_page_path(id: page.id)
    }, status: 422
  end

end