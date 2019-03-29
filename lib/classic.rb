class Classic < Gamemode
  def game_over
    super
    if @life > 0
      puts "\nYou should hear a *click* any second now, that would be the door. You're free to go - until next time :)"
    else
      puts "\nMaybe in another life..."
    end
    sleep(1)
  end
end
