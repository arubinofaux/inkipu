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

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
