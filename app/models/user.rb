class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  enum roles: [:ads_space_provider, :organisation, :ads_space_agent]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :ads_space_provider
  end

end
