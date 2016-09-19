class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :default_role
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
def ldap_before_save
  # self.email = Devise::LDAP::Adapter.get_ldap_param(self.name,"mail").first
end
private
  def default_role
    self.roles << Role.find_by_name("user")
		self.save
  end
end
