require_relative "game_controller.rb"
require_relative "user.rb"
require "tty-prompt"
require "random-word"

gameController = GameController.new()
gameController.start_screen