module Admin::AdminUsersHelper

  def user_access_list(admin_user, model)
    raw admin_user.access_list(model).compact.map{ |n| I18n.t(n.to_sym, scope: "policy.#{model}") }.join(' | ')
  rescue
    raw "<em>Žádná práva</em>"
  end

end
