module Admin::AdminUserPoliciesHelper

  def policy_check_box(g, model, name)
    g.label name.to_sym, class: 'checkbox-inline' do
      raw "#{g.check_box(name.to_sym, {checked: @admin_user.has_access_to?(model, name)})} #{I18n.t(name.to_sym, scope: "policy.#{model}")}"
    end
  end

end
