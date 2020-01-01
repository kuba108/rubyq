class DashboardPolicy < AdminBasePolicy

  def show?
    true
  end

  def show_stats?
    policies.include?('show_stats')
  end

  private

  def policies
    @user.policies['dashboard'].map{|k, v| k if v == '1'}
  rescue
    []
  end

end