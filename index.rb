require_relative "game_controller.rb"
require_relative "user.rb"
require 'colorize'

gameController = GameController.new() #initialise gamecontroller class
if ARGV[0] == "-h" #command line argument that calls help function
    gameController.help
else
    ARGV.each do |i|
        gameController.attempt_registration(i.chomp) #command line argument that registers each user
    end 
end
while ARGV.size > 0 #loop while there are elements in ARGV
    ARGV.shift #delete ARGV so that application can get input later using 'gets'
end
gameController.start_screen #start application

