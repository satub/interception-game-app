module ApplicationHelper

  def current_game
    current_player.current_game
  end

  def greeting(player)
    player.nil? ? (content_tag :h1, "Welcome to Interception!") : (content_tag :h1, "Welcome to Interception, #{player.alias}!")
  end

  def page_content(player)
    if player.nil?
      content_tag :h3, "Please log in or signup to continue! :D"
    else
      link_to "Last played: #{current_game.title}", game_path(current_game) if current_game
    end
  end

  def player_status
    "Logged in as #{current_player.alias}" if current_player
  end

  def game_status
    link_to("Game: #{current_game.title}; Status: #{current_game.status}", game_path(current_game)) if current_game
  end

  def turn_status
    if current_game
      "#{current_game.whose_turn_is_it_anyway}'s turn." if game_active?
    end
  end

  def print_character_status(game_id, character_id)
    gc = in_use?(game_id, character_id)
    gc.nil? ? "Character not in use in this game" : "Troops: #{gc.troops}"
  end

  def in_use?(game_id, character_id)
    GameCharacter.character_in_use?(game_id, character_id)
  end

  def game_status_message
    if current_game
      case current_game.status
      when "pending"
        "Waiting for other players to join..."
      when "active"
         current_player.id != current_game.turn ? "Waiting for turn" : "Pick your target"
       when "finished"
         "This Game Is Over!"
      end
    end
  end

  def no_more?
    if current_game
      if current_game.no_more_characters?(current_player)
        content_tag :h5, "Can't assign any more characters to this game. You can still create new characters to be used in other games."
      end
    end
  end

  def game_active?
    current_game.status == "active"
  end

  def successful?(event)
     event.success ? "success" : "failure"
  end

  def defense(location)
    location.controlled_by == current_player.id ? (content_tag :h5, "Current defense: #{location.defense}") : ""
  end

  def active_characters
    Character.active_characters(current_game, current_player)
  end

  def who(player_id)
    Player.player_who(player_id)
  end

  def who_am_i(id)
    Character.who_am_i(id)
  end

  def can_be_added?(player)
    if current_game
      current_game.joinable? && !current_game.no_more_characters?(player)
    end
  end

  def location_status(location, i)
      link_to "#{i+1}. In control: #{location.player_in_control}", game_location_path(current_game, location)
  end

  def location_action(location)
    (link_to "Take Over!", edit_game_location_path(current_game, location)) if possible_target?(location) && game_active?
  end


  def possible_target?(location)
    current_player.id == current_game.turn && location.controlled_by != current_player.id
  end

  def game_joinable?
    if current_game
      current_game.joinable? && !current_game.game_players.detect { |gp| current_player.id == gp.player_id }
    end
  end


end
