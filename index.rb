require_relative "game_controller.rb"
require_relative "user.rb"
require 'artii'

artOpts = Artii::Base.new :font => 'slant' #create artii options using Artii Ruby gem
puts artOpts.asciify('Type King') #apply artii style to string to output to the application
gameController = GameController.new() #initialise gamecontroller class
gameController.start_screen #start application