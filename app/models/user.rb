class User < ActiveRecord::Base
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :trackable, :validatable
has_many :authentications
has_many :repos

  def self.from_omniauth(auth)
    binding.pry
    password = Devise.friendly_token.first(8)
    user = User.find_by(email: auth["info"]["email"])
    unless user.present?
      user = User.create(email: auth["info"]["email"],password: password, password_confirmation: password,name: auth["extra"]["raw_info"]["login"],oauth_token: auth["credentials"]["token"])
    end 
    authentication = user.authentications.find_or_create_by(provider: auth['provider'],uid: auth['uid'])
    if authentication.present?
      user = authentication.user
    end

    user.authentications.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    user
  end
end
