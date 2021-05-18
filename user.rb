require "tty-progressbar"
require_relative "database.rb"

class User
    attr_reader :name, :highScore
    
    def initialize(name, highScore)
        @name = name
        @highScore = 0
    end

    def user_details()
        return {@name => @highScore}
    end

end


