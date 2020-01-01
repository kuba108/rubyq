class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    self.email == 'kuba@elegantniweb.cz'
  end

  def policies
    self.acl['policies']
  end

  def acl_list(model)
    policies[model]
  rescue
    []
  end

  def access_list(model)
    acl_list(model).map{ |k,v| k if v == '1' }
  end

  def denied_list(model)
    acl_list(model).map{ |k,v| k if v == '0' }
  end

  def has_access_to?(model, name)
    policies[model][name] == '1'
  rescue
    false
  end

end
