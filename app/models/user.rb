require 'open3'

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

def save_in_ldap
  file = File.open("/home/ricardo/users.ldif", "w")
  file.write("dn: uid=" + self.email + ",ou=tech,test,dc=com
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: " + self.email + "
uid: " + self.email + "
uidNumber: 20000
gidNumber: 20000
homeDirectory: /home/" + self.email + "
loginShell: /bin/bash
gecos: " + self.email + ",user,user,435-555-555,801-555-555
userPassword: " + self.password + "
shadowLastChange: 0
shadowMax: 0
shadowWarning: 0")

  file.close

  add_ldap = 'ldapadd -x -w "admin" -D "cn=admin,test,dc=com" -f /home/ricardo/users.ldif'
  system add_ldap

  File.delete("/home/ricardo/users.ldif")
end

private
  def default_role
    self.roles << Role.find_by_name("user")
		self.save
    save_in_ldap
  end
end
