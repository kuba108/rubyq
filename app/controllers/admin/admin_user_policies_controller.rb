class Admin::AdminUserPoliciesController < Admin::BaseController

  def index
    @admin_user = AdminUser.find(params[:admin_user_id])
    authorize @admin_user, :update_acl?
  end

  def update
    admin_user = AdminUser.find(params[:admin_user_id])
    authorize admin_user, :update_acl?
    acl_params = admin_user_acl_params
    admin_user.acl = { policies: acl_params }
    admin_user.save!
    flash[:notice] = "Uživatelská práva byla upravena."
    redirect_to action: 'index', admin_user_id: admin_user.id
  end

  private

  def admin_user_acl_params
    params.require(:admin_user).require(:acl)
  end

end