require_relative "database.rb"
require_relative "user.rb"
require "tty-prompt"

@database = Database.new()

def start_screen()
    startChoices = {Login: 1, "New User": 2, Leaderboards: 3}
    startPrompt = TTY::Prompt.new
    choice = startPrompt.select("Welcome to Type Race King", startChoices) 
        if choice == 1
            @database.user_login
        elsif
            choice == 2
            @database.user_register
        else
            @database.show_users
        end
end

start_screen
start_screen