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

  def who_am_i(id)
    Character.who_am_i(id)
  end

  def can_be_added?
    if current_game
      current_game.joinable?
    end
  end

end
