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
        provider: auth.provider,
        uid: auth.uid,
        email: "#{auth.uid}@TEMP-#{auth.provider}.com",
        password: Devise.friendly_token[0,20]
      )

      # check if we have a player without a user
      pp = Player.find_by_bnet_name(auth.info.battletag)
      if pp && pp.user_id.nil?
        pp.update(user_id: newUser.id)
      else
        Player.create(user_id: newUser.id, name: auth.info.battletag.split("#")[0], bnet_name: auth.info.battletag)
      end
      return newUser
    else
      return pingUser
    end
  end
end
