class MenuPolicy < AdminBasePolicy

  def index?
    policies.include?('index')
  end

  def show?
    policies.include?('show')
  end

  def create?
    policies.include?('create')
  end

  def update?
    policies.include?('update')
  end

  def destroy?
    policies.include?('destroy')
  end

  alias_method :edit?, :update?
  alias_method :new?, :create?
  alias_method :change_order?, :update?

  private

  def policies
    @user.policies['menu'].map{|k, v| k if v == '1'}
  rescue
    []
  end

end