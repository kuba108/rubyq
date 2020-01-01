class Admin::AdminUsersController < Admin::BaseController

  def index
    authorize AdminUser
    @search = AdminUser.all.order(created_at: :desc).ransack(params[:q])
    @admin_users = @search.result.paginate(page: page_number, per_page: per_page)
  end

  def show
    @admin_user = AdminUser.find(params[:id])
    authorize @admin_user
  end

  def new
    @admin_user = AdminUser.new
    authorize @admin_user
  end

  def create
    authorize AdminUser
    AdminUser.create!(admin_user_params.merge({ acl: {} }))
    flash[:notice] = "Uživatel byl vytvořen."
    redirect_to action: :index
  end

  def update
    admin_user = AdminUser.find(params[:id])
    authorize admin_user
    admin_user.update_attributes(admin_user_params)
    admin_user.save!
    render json: {
      result: 'success'
    }.merge(component_render(params, admin_user_params))
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue => e
    render Controller::Responder.unknown_error(e).merge(component_render(params, admin_user_params)), status: 422
  end

  def destroy
    admin_user = AdminUser.find(params[:id])
    authorize admin_user
    name = admin_user.full_name
    admin_user.destroy!
    render json: {
      result: 'success',
      msg: "Uživatel #{name} byl smazán.",
      redirect_path: admin_admin_users_path
    }
  rescue Pundit::NotAuthorizedError => e
    render Pundit::Responder.not_authorized
  rescue
    render json: {
      result: 'error',
      msg: "Uživatel #{name} nebyl smazán.",
      redirect_path: admin_admin_users_path
    }, status: 422
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation, :acl)
  end

  def page_number
    params[:page].to_i > 0 ? params[:page].to_i : 1
  end

  def per_page
    params[:per_page].to_i > 0 ? params[:per_page].to_i : 100
  end

end
