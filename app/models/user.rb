class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :default_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

private
  def default_role
    self.roles << Role.find_by_name("user")
		self.save
  end
end
