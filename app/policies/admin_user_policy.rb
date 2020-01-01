class AdminUserPolicy < AdminBasePolicy

  def index?
    policies.include?('index') || @user.admin?
  end

  def show?
    policies.include?('show') || @user.admin?
  end

  def create?
    policies.include?('create') || @user.admin?
  end

  def update?
    policies.include?('update') || @user.admin?
  end

  def destroy?
    policies.include?('destroy') || @user.admin?
  end

  def update_acl?
    policies.include?('update_acl') || @user.admin?
  end

  def change_passwords?
    policies.include?('change_passwords') || @user.admin?
  end

  alias_method :edit?, :update?
  alias_method :new?, :create?
  alias_method :edit_acl?, :update_acl?

  private

  def policies
    @user.policies['admin_user'].map{|k, v| k if v == '1'}
  rescue
    []
  end

end