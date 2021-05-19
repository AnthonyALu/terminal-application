require "random-word"
require 'colorize'
require "tty-prompt"

class GameController

    attr_accessor :userHashes, :currentUser
    attr_reader :gameFinished
    def initialize()
    @userHashes = {}
    @wordsLeft = 0
    end

    def start_screen()
        startChoices = {Login: 1, "New User": 2, Leaderboards: 3, Exit: 4}
        startPrompt = TTY::Prompt.new
        choice = startPrompt.select("Welcome to Type Champion", startChoices) 
            if choice == 1
                user_login
            elsif choice == 2
                user_register
            elsif choice == 3
                show_users
            else
            puts "Thank you for playing!"   
            end
    end

    def user_register
        registerPrompt = TTY::Prompt.new #create new prompt
        username = registerPrompt.ask("What is your name?", default: "Anonymous") #ask for user name, default is 'anonymous'
        puts attempt_registration(username) #calls attempt_registration method with username to check if user exists
        start_screen #return to start screen so user can login
    end

    def attempt_registration(username)
        if @userHashes[username] #check if user exists in @userHashes
            return "You already have an account, please login"
        else
            user = User.new(username, 0) #creates new user
            newHash = user.user_details #creates a new hash of user values
            @userHashes.merge!(newHash) #adds user to hash
            return "Thank you for registering, please login and have fun!"
        end
    end

    def user_login
        loginPrompt = TTY::Prompt.new
        username = loginPrompt.ask("What is your name?", default: "Anonymous")
        puts(attempt_login(username))
            if @userHashes[username]
                home_screen
            else
                start_screen
            end
    end

    def attempt_login(username)
        if @userHashes[username]
            @currentUser = username
            return "Hello #{username}!"
        else
            return "You have not registered yet, please register first."
        end 
    end

    def show_users
        @userHashes.each do |user|
            puts user
        end
    end

    def show_stats()
        return @userHashes[@currentUser]
        return @currentUser
    end

    def home_screen
        entryPrompt = TTY::Prompt.new #creates new prompt
        entryChoices = {Play: 1, Stats: 2, "Log out": 3} #options to choose from
        choice = entryPrompt.select("Hello #{@currentUser}, what would you like to do?", entryChoices) #receives choice input
        if choice == 1 #play game selected
            start_game #starts game
        elsif choice == 2 #stats selected
            puts show_stats #show user stats
            home_screen #restart method
        else
            start_screen #logs out
        end
    end

    def start_game
        wordsPrompt = TTY::Prompt.new
        words = wordsPrompt.ask("How many words do you want to type? (enter a number between 5 and 500)", default: 100)
        if words.to_i < 5 || words.to_i > 499
            puts "Invalid entry, please enter a number larger than 5 and smaller than 500"
            start_game
        else
            countdown = 3
            while countdown>0 do
            puts countdown
            countdown -= 1
            sleep 1
            end
            begin_typing(words)
        end
    end


    def begin_typing(wordCount)
        wordsCorrect = []
        wordsIncorrect = []
        starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        @wordsLeft = wordCount.to_i #words left to type are the words passed in argument from previous def
        while @wordsLeft > 0
            newWord = RandomWord.nouns.next
            while newWord.size > 8 #makes sure no words are over 8 characters long
                random = rand (2)
                if rand == 1
                    newWord = RandomWord.adjs.next
                else
                    newWord = RandomWord.nouns.next
                end
            end
            puts newWord
            input = gets.chomp
            if newWord == input
                wordsCorrect << newWord.colorize(:green)
            else
                wordsIncorrect << newWord.colorize(:red)
            end
            @wordsLeft -= 1
        end
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        finalTime = (elapsed - starting)
        calculate_results(finalTime, wordCount, wordsCorrect, wordsIncorrect)
    end

    def calculate_results(finalTime, totalWordCount, wordsCorrect, wordsIncorrect)
        puts "Your final time to type #{totalWordCount} was #{finalTime.round} seconds"
        puts "Words typed correctly: #{wordsCorrect.join(" ")}"
        puts "Words typed incorrectly: #{wordsIncorrect.join(" ")}"
        puts "Calculating..."
        calculate_speed(finalTime, totalWordCount, wordsCorrect)

    end

    def count_letters(input)
        letter_count = {}
        downcase_letters = input.delete(' ').split("")
        downcase_letters.each do |letter|
        p letter
        if !letter_count[letter]
            letter_count[letter] = 1
            else
            letter_count[letter] += 1
            end
        end
        # Populate letter_count using an iterator 
        return letter_count
    end

    def calculate_speed(finalTime, totalWordCount, wordsCorrect)
        charactersTyped = 0
        wordsCorrect.each do |word|
            word = word.green.uncolorize
            puts word.size
            charactersTyped += word.size
        end
        timeMultiplier = 60 / finalTime 
        puts timeMultiplier
        puts charactersTyped
        wordsNormalized = charactersTyped * timeMultiplier
        wpm = ((wordsNormalized / 2.5)).round 
        puts "You type #{wpm.to_s.colorize(:green)} word(s) per minute!"

    end
end