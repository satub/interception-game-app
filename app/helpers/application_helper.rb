module ApplicationHelper
  def current_game
    current_player.current_game
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

  def active_characters
    Character.active_characters(current_game, current_player)
  end

  def who(player_id)
    Player.player_who(player_id)
  end

  def who_am_i(id)
    Character.who_am_i(id)
  end

  def can_be_added?
    if current_game
      current_game.joinable?
    end
  end

  def possible_target?(location)
    current_player.id == current_game.turn && location.controlled_by != current_player.id
  end

  def game_active?
    current_game.status == "active"
  end

  def game_joinable?
    current_game.joinable? && !current_game.game_players.detect { |gp| current_player.id == gp.player_id }
  end

  def successful?(event)
     event.success ? "success" : "failure"
  end

  def defense(location)
    "Current defense: #{location.defense}" if location.controlled_by == current_player.id
  end

  def in_use?(game_id, character_id)
    GameCharacter.character_in_use?(game_id, character_id)
  end

  def print_character_status(game_id, character_id)
    gc = GameCharacter.find_by(game_id: game_id, character_id: character_id) if in_use?(game_id, character_id)
    "Troops: #{gc.troops}"
  end
end
