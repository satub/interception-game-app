class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,    :recoverable, :rememberable,and
  devise :database_authenticatable, :registerable,
        :trackable, :validatable, :omniauthable, omniauth_providers: [:github]

  has_many :game_players
  has_many :games, through: :game_players
  has_many :characters
  has_one :current_game, class_name: :game

  ##Custom validation:
  ####validates that alias is not a direct substring of email

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |player|
    auth[:info][:email].nil? ?   player.email = "#{auth[:info][:nickname]}@faked.org" : player.email = auth[:info][:email]
    player.alias = auth[:info][:nickname]
    #if email from provider is null => create a fake one and ask user later for another one???
    #if your email is not public on GitHub, then the omniauth hash does not have that info! :o
    end
  end


  def current_game=(game)
    game.nil? ? self.current_game_id = nil : self.current_game_id = game.id
    self.save
  end

  def current_game
    Game.find_by(id: self.current_game_id)
  end

end
