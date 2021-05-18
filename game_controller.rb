
class GameController

    attr_accessor :userHashes
    attr_accessor :currentUser
    def initialize()
    @@userHashes = {}
    end

    def start_screen()
        startChoices = {Login: 1, "New User": 2, Leaderboards: 3}
        startPrompt = TTY::Prompt.new
        choice = startPrompt.select("Welcome to Type Champion", startChoices) 
            if choice == 1
                user_login
            elsif
                choice == 2
                user_register
            else
                show_users
            end
    end

    def user_register
        registerPrompt = TTY::Prompt.new
        username = registerPrompt.ask("What is your name?", default: "Anonymous")
            if @@userHashes[username]
                puts "You already have an account, please login"
                start_screen
            else
                user = User.new(username, 0)
                newHash = user.user_details
                @@userHashes.merge!(newHash)
                puts "Thank you for registering, please login and have fun!"
                start_screen
            end
    end

    def user_login
        loginPrompt = TTY::Prompt.new
        username = loginPrompt.ask("What is your name?", default: "Anonymous")
            if @@userHashes[username]
                @currentUser = username
                home_screen
            else
                puts "You have not registered yet, please register first."
                start_screen
            end
    end

    def show_users
        @@userHashes.each do |user|
            puts user
        end
    end

    def show_stats()
        return @@userHashes[@currentUser]
        return @currentUser
    end

    def home_screen
        entryPrompt = TTY::Prompt.new
        entryChoices = {Play: 1, Stats: 2, "Log out": 3}
        choice = entryPrompt.select("Hello #{@currentUser}, what would you like to do?", entryChoices)
        if choice == 1
            start_game
        elsif
            choice == 2
            puts show_stats
            home_screen
        else
            start_screen
        end
    end

    def start_game
        secondsPrompt = TTY::Prompt.new
        seconds = secondsPrompt.ask("How long do you want to type for? (enter a number between 15-300)", default: 60)
        if seconds.to_i < 15 || seconds.to_i > 300
            puts "Invalid entry, please enter a number between 15 to 300"
            start_game
        else
            countdown = 3
            while countdown>0 do
            puts countdown
            countdown -= 1
            sleep 1
            end
            begin_typing
        end
    end

    def begin_typing
        puts "hey"
    end
end