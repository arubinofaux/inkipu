class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :omniauthable
  
  has_many :player_matches, class_name: "Match", foreign_key: :player_id
  has_many :opponent_matches, class_name: "Match", foreign_key: :opponent_id
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.name = auth.info.battletag.split("#")[0]
      user.bnet_name = auth.info.battletag
      user.uid = auth.uid
      user.email = "#{auth.uid}@TEMP-#{auth.provider}.com"
      user.password = Devise.friendly_token[0,20]
    end
  end
end
