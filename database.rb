
class Database

    attr_accessor :userHashes
    def initialize()
    @userHashes = {}  
    end

    def user_register
        registerPrompt = TTY::Prompt.new
        username = registerPrompt.ask("What is your name?", default: "Anonymous")
            if @userHashes[username]
                puts "stop"
            else
                user = User.new(username, 0)
                puts username
                newHash = user.user_details
                puts newHash
                @userHashes.merge!(newHash)
            end
            show_users
    end

    def user_login
        loginPrompt = TTY::Prompt.new
        username = loginPrompt.ask("What is your name?", default: "Anonymous")
            if @userHashes[username]
                entryPrompt = TTY::Prompt.new
                entryChoices = {Play: 1, Stats: 2, "Change User": 3}
                choice = entryPrompt.select("Hello #{username}", entryChoices)
            else
                puts "You have not registered yet"
            end
            show_users
    end

    def show_users
        @userHashes.each do |user|
            puts user
        end
    end

end