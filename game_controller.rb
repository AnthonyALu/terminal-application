require "random-word"
require 'colorize'
require "tty-prompt"

class GameController

    attr_accessor :userHashes, :currentUid, :currentUserData, :userData
    def initialize()
    @userData = [] #database of user hashes
    @userHashes = {} #stores indexes for all users
    @currentUserData = {} #stores current stats
    @currentUid = 0 #current user id
    @leaderboardArr = []
    end

    def start_screen()
        startChoices = {Login: 1, "New User": 2, Leaderboards: 3, Exit: 4} #Options for starting screen
        startPrompt = TTY::Prompt.new #creates new prompt
        choice = startPrompt.select("Welcome to Type Champion", startChoices) #receive input for prompt
            if choice == 1 #user picked Login
                user_login
            elsif choice == 2 #user picked New User
                user_register
            elsif choice == 3 #user picked Leaderboards
                show_leaderboards
            else #user picked exit
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
            @userhashes = @userHashes.merge!(newHash) #adds user to hash 
            @userData << {:name => username, :high_score => 0, :accuracy => 0, :worst_character => "None!"}
            return "Thank you for registering, please login and have fun!"
        end
    end

    def user_login
        loginPrompt = TTY::Prompt.new #creates new prompt
        username = loginPrompt.ask("What is your name?", default: "Anonymous") #receive prompt input
        puts(attempt_login(username)) #attempt to login 
        if @userHashes[username]
            home_screen #if user exists go to home screen
        else
            start_screen #otherwise go back to start screen
        end
    end

    def attempt_login(username)
        if @userHashes[username] #check if user exists
            @currentUid = @userHashes[username] #update current user id to the username from the userhashes directory
            puts @currentUid
            puts @userhashes
            puts @userData
            @currentUserData = @userData[currentUid] #user data hash becomes hash from database
            return "Hello #{currentUserData[:name]}!"
        else
            return "You have not registered yet, please register first."
        end 
    end

    def show_leaderboards
        @leaderboardArr = @userData.dup
        if @leaderboardArr.count > 0
            @leaderboardArr.sort_by!{|w| w[:high_score]}
            @leaderboardArr = @leaderboardArr.reverse
            leaderCount = @leaderboardArr.count
            if leaderCount > 2
                leaderCount = 0
                while leaderCount < 3
                    leaderHash = @leaderboardArr[leaderCount]
                    puts "#{leaderCount+1}. #{leaderHash[:name]} - WPM: #{leaderHash[:high_score]}, Accuracy: #{leaderHash[:accuracy]}, Worst Character: #{leaderHash[:worst_character]}"
                    leaderCount +=1
                end
            elsif leaderCount == 2
                leaderCount = 0
                while leaderCount < 2
                    leaderHash = @leaderboardArr[leaderCount]
                    puts "#{leaderCount+1}. #{leaderHash[:name]} - WPM: #{leaderHash[:high_score]}, Accuracy: #{leaderHash[:accuracy]}, Worst Character: #{leaderHash[:worst_character]}"
                    leaderCount +=1
                end
            else
                #leaderCount == 1
                leaderCount =0
                leaderHash = @leaderboardArr[leaderCount-1]
                puts "#{leaderCount+1}. #{leaderHash[:name]} - WPM: #{leaderHash[:high_score]}, Accuracy: #{leaderHash[:accuracy]}, Worst Character: #{leaderHash[:worst_character]}"
            end
        else
            puts "No entries yet!"
        end
        start_screen
    end

    def show_stats()
        @currentUserData = @userData[@currentUid] #double check that the stats shown are the highest/used for testing
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
        wordsLeft = wordCount.to_i #words left to type are the words passed in argument from previous def
        while wordsLeft > 0 #loops while there are words to type
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
            wordsLeft -= 1 #user has typed another word
        end
        finishTime = Process.clock_gettime(Process::CLOCK_MONOTONIC) #gets current time and stores it in variable
        elapsedTime = (finishTime - startingTime) #gets time elapsed by subtracting starting time from the finished time
        calculate_results(elapsedTime, wordCount, wordsCorrect, wordsIncorrect) #calculate results using elapsed time, how many words the user typed and words that the user got correct/incorrect
    end

    def calculate_results(elapsedTime, totalWordCount, wordsCorrect, wordsIncorrect)
        puts "Your final time to type #{totalWordCount} words was #{elapsedTime.round} seconds" #tells the user how long it took them to type the designated words
        puts "Words typed correctly: #{wordsCorrect.join(" ")}" #shows all correctly typed words seperated by a space
        puts "Words typed incorrectly: #{wordsIncorrect.join(" ")}" #shows all incorrectly typed words seperated by a space
        puts "Calculating..."
        puts calculate_speed(elapsedTime, totalWordCount, wordsCorrect) #returns wpm and accuracy
        puts count_worst_letters(wordsIncorrect) #returns array of top 3 incorrect letters typed
        home_screen #return to home screen
    end

    def count_worst_letters(incorrectWords)
        letter_count = {} #create new array of letters incorrectly typed
        incorrectWords.each do |word| #loop through each word
            word = word.red.uncolorize #uncolorize to remove colorize characters
            letterArr = word.split("") #split word into array of letters
            letterArr.each do |letter| #loop through each letter
                if !letter_count[letter] #if letter does not exist in hash, add it to hash
                    letter_count[letter] = 1
                    else
                    letter_count[letter] += 1 #if letter exists, increment
                end
            end
        end
        if letter_count.empty? #check if hash is empty, meaning that they got everything correct
            return "Great job, you got all the words correct!"
        else
            final_letters = letter_count.sort_by {|char, c| c}.reverse #sort hash by descending order
            @currentUserData[:worst_character] = letter_count.max_by{|k, v| v} #change worst character in database to be the key with the highest value
            return "Here are some characters that you may want to practice: #{final_letters[0]}, #{final_letters[1]}, #{final_letters[2]}"
        end
    end

    def calculate_speed(elapsedTime, totalWordCount, wordsCorrect)
        charactersTyped = 0 #checks how many characters were typed
        wordsCorrect.each do |word|
            word = word.green.uncolorize #uncolorizes words so that word size will revert to normal
            charactersTyped += word.size #adds characters of words to character count
        end
        timeMultiplier = 60 / elapsedTime  #creates a multiplier to set typing rate to words per minute
        wordsNormalized = charactersTyped * timeMultiplier #converts characters typed to characters per minute
        wpm = ((wordsNormalized / 3)).round #wpm = characters typed per minute divided by average characters in words. Average is lower to be more accurate because user has to use the enter button and is not typing sentences
        puts wordsCorrect.count
        puts totalWordCount
        accuracy = (wordsCorrect.count.to_f / totalWordCount.to_f) * 100 #accuracy = correct words / total words
        puts accuracy
        save_data(wpm, accuracy.to_i) #saves data if user has reached high score
        return "You type #{wpm.to_s.colorize(:green)} word(s) per minute with #{accuracy.to_i}% accuracy!" #returns wpm and accuracy
    end

    def save_data(wpm, accuracy)
        if wpm > @currentUserData[:high_score]
            #save data if user reaches new high score
            @currentUserData[:high_score] = wpm #updates highest wpm
            @currentUserData[:accuracy] = accuracy #updates accuracy
            @userData[@currentUid] = @currentUserData #updates database with current user data
            puts @userData
        else
            #do not save data
        end
    end
end