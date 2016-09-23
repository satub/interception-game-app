class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |player|
    auth[:info][:email].nil? ?   player.email = "#{auth[:info][:nickname]}@faked.org" : player.email = auth[:info][:email]
    player.alias = auth[:info][:nickname]
    #if email from provider is null => create a fake one and ask user later for another one???
    #if your email is not public on GitHub, then the omniauth hash does not have that info! :o
    end
  end
end
