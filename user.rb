class User
    attr_reader :name, :uid, :userCount
    @@userCount = 0
    
    def initialize(name)
        @name = name
        @uid = @@userCount
        @@userCount +=1
        puts @@userCount
    end

    def user_details()
        return {@name => @uid}
    end

end


