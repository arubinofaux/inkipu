class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable
  
  has_one :player
  
  def self.from_omniauth(auth)
    pingUser = where(provider: auth.provider, uid: auth.uid).first
    if pingUser.blank?
      newUser = User.create(
        provider: auth.uid,
        uid: auth.uid,
        email: "#{auth.uid}@TEMP-#{auth.provider}.com",
        password: Devise.friendly_token[0,20]
      )
      Player.create(user_id: newUser.id, name: auth.info.battletag.split("#")[0], bnet_name: auth.info.battletag)
      return newUser
    else
      return pingUser
    end

    # user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #   user.provider = auth.provider
    #   user.uid = auth.uid
    #   user.email = "#{auth.uid}@TEMP-#{auth.provider}.com"
    #   user.password = Devise.friendly_token[0,20]
    # end
    # Player.create(user_id: user.id, name: auth.info.battletag.split("#")[0], bnet_name: auth.info.battletag)
  end
end
