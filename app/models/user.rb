class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :authentications
  has_many :repos

  def self.from_omniauth(auth)
    #binding.pry
    
    password = Devise.friendly_token.first(8)
   # u= User.create_with(password: password, password_confirmation: password,name: auth["extra"]["raw_info"]["login"])
     #user = u.find_or_create_by(email: auth["info"]["email"])
     user = User.find_by(email: auth["info"]["email"])
     unless user.present?
       user = User.create(email: auth["info"]["email"],password: password, password_confirmation: password,name: auth["extra"]["raw_info"]["login"])
      end 
     #binding.pry
     authentication = user.authentications.find_or_create_by(provider: auth['provider'],uid: auth['uid'])
     #binding.pry
     if authentication.present?
        user = authentication.user
      end
     
     user.authentications.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
     user
=begin
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = auth.password
      #user.password_confirmation = auth.info.password_confirmation
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
=end

  end
end
