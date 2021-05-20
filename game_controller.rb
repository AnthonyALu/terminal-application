require "random-word"
require 'colorize'
require "tty-prompt"

class GameController

    attr_accessor :userHashes, :currentUid, :currentUserData, :userData
    attr_reader :gameFinished
    def initialize()
    @userData = []
    @userHashes = {}
    @currentUserData = {}
    @wordsLeft = 0
    @currentUid = 0
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
            user = User.new(username) #creates new user
            newHash = user.user_details #creates a new hash of user values
            @userHashes.merge!(newHash) #adds user to hash
            @userData << {:name => username, :high_score => 0, :accuracy => 0, :worst_character => "None!"}
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
            @currentUid = @userHashes[username]
            @currentUserData = @userData[currentUid]
            return "Hello #{currentUserData[:name]}!"
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
        @currentUserData = @userData[@currentUid]
        return "Name: #{@currentUserData[:name]}, WPM: #{@currentUserData[:high_score]}, Accuracy: #{@currentUserData[:accuracy]}, Least accurate letter: #{@currentUserData[:worst_character]}"
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
        wordsPrompt = TTY::Prompt.new #creates new prompt
        words = wordsPrompt.ask("How many words do you want to type? (enter a number between 5 and 500)", default: 60) #asks user for number of words they would like to type. If no input, defaults to 30
        if words.to_i < 5 || words.to_i > 499 #checks if entry is in range
            puts "Invalid entry, please enter a number larger than 5 and smaller than 500"
            start_game #restarts method
        else
            countdown = 3 #starts countdown to game
            while countdown>0 do #loops while countown is higher than 0
            puts countdown
            countdown -= 1
            sleep 1 #waits 1 second
            end
            begin_typing(words) #starts games with chosen number of words
        end
    end

    def begin_typing(wordCount)
        wordsCorrect = [] #creates array of words that the user types correctly
        wordsIncorrect = [] #creates array of words that the user types incorrectly
        startingTime = Process.clock_gettime(Process::CLOCK_MONOTONIC) #gets current time and saves it in variable
        @wordsLeft = wordCount.to_i #words left to type are the words passed in argument from previous def
        while @wordsLeft > 0 #loops while there are words to type
            newWord = RandomWord.nouns.next #starts with a random noun
            while newWord.size > 8 #makes sure no words are over 8 characters long, generates a new word if the new word is longer than 8 characters
                random = rand(2) #generators a random number from 0-1
                if random == 1
                    newWord = RandomWord.adjs.next #if random number is '1', next word is an adjective
                else
                    newWord = RandomWord.nouns.next #if random number is not '1', next word is a noun
                end
            end
            puts newWord #prints word for user to type
            input = gets.chomp
            if newWord == input #checks if user has typed the word correctly
                wordsCorrect << newWord.colorize(:green) #changes colour of word to green and pushes it to correct words array
            else
                wordsIncorrect << newWord.colorize(:red) #changes colour of word to red and pushes it to incorrect words array
            end
            @wordsLeft -= 1 #user has typed another word
        end
        finishTime = Process.clock_gettime(Process::CLOCK_MONOTONIC) #gets current time and stores it in variable
        elapsedTime = (finishTime - startingTime) #gets time elapsed by subtracting starting time from the finished time
        calculate_results(elapsedTime, wordCount, wordsCorrect, wordsIncorrect) #calculate results using elapsed time, how many words the user typed and words that the user got correct/incorrect
    end

    def calculate_results(elapsedTime, totalWordCount, wordsCorrect, wordsIncorrect)
        puts "Your final time to type #{totalWordCount} words was #{finalTime.round} seconds" #tells the user how long it took them to type the designated words
        puts "Words typed correctly: #{wordsCorrect.join(" ")}" #shows all correctly typed words seperated by a space
        puts "Words typed incorrectly: #{wordsIncorrect.join(" ")}" #shows all incorrectly typed words seperated by a space
        puts "Calculating..."
        calculate_speed(elapsedTime, totalWordCount, wordsCorrect) #returns wpm and accuracy
        puts count_letters(incorrectWords)
    end

    def count_letters(incorrectWords)
        letter_count = {}
        incorrectWords.each do |word|
            letterArr = word.split("")
            letterArr.each do |letter|
                if !letter_count[letter]
                    letter_count[letter] = 1
                    else
                    letter_count[letter] += 1
                end
            end
        end

        
        # Populate letter_count using an iterator 
        return letter_count
    end

    def calculate_speed(elapsedTime, totalWordCount, wordsCorrect)
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