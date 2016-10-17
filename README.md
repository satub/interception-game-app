# README
This app was created for the Flatironschool Webdev-Fellowship Rails Assessment Project
The Jails branch is for adding JavaScript to the domain as per JavaScript and Rails Assessment requirements.

* Configuration
  You'll need github keys to enable the omniauth sign-in and login-in features. To prevent these keys from being pushed up to github, you need to exclude the file you have them in the .gitignore file. The devise.rb initializer in this repo has been set to read them from a separate Key class located in a non-tracked directory:

  _config/initializers/devise.rb:_
  `require_relative '../../donut/keys.rb'
  Devise.setup do |config|
    #Fetch my keys from my secret class
    keys = Key.new
    ....
    # ==> OmniAuth
    # Add a new OmniAuth provider. Check the wiki for more information on setting
    # up on your models and hooks.
    # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'player,public_repo'
    config.omniauth :github, keys.github_id, keys.github_secret,  scope: 'player,public_repo'`

  _.gitignore:_
  `# Ignore everything in the /donut-dir
  /donut/*
  !/donut/.keep`

  _donut/keys.rb:_
  `class Key

    attr_reader :github_id, :github_secret

    def initialize
      @github_id = 'YOUR GITHUB KEY HERE'
      @github_secret = 'YOUR GITHUB SECRET HERE'
    end

  end`



* Database creation
  rake db:migrate
