require_relative "../user.rb"
require_relative "../game_controller.rb"


describe GameController do
    before(:each) do #initiate user and class
        @controller = GameController.new()
        @controller.currentUid = 0
        @controller.userHashes = {"Bob" => 0, "Steve" => 1} #initialize users 'Bob' and 'Steve'
        @controller.userData << {:name => "Bob", :high_score => 0, :accuracy => 0, :worst_character => "None!"}
        @controller.userData << {:name => "Steve", :high_score => 0, :accuracy => 0, :worst_character => "None!"}
        @controller.currentUserData = @controller.userData[0]
    end

    it "should show stats" do #test that application shows stats using the stats feature
        expect(@controller.show_stats).to eq("Name: Bob, WPM: 0, Accuracy: 0, Least accurate letter: None!") #shows stats for 'Bob'
    end

    it "should show stats for other users in hash" do #test that application shows stats using the stats feature
        @controller.currentUid = 1
        expect(@controller.show_stats).to eq("Name: Steve, WPM: 0, Accuracy: 0, Least accurate letter: None!") #shows stats for 'Steve'
    end

    it "should stop users from registering if name already exists" do #tests that application prevents user from registering with the registration feature if the user already exists
        expect(@controller.attempt_registration("Bob")). to eq("You already have an account, please login") #should prevent 'Bob' from registering
    end

    it "should stop users from registering if name already exists" do #tests that application prevents user from registering with the registration feature if the user already exists
        expect(@controller.attempt_registration("Steve")). to eq("You already have an account, please login") #should prevent 'Steve' from registering
    end

    it "should allow users to register if name does not exist" do #tests that application allows user to register if their account does not exist
        expect(@controller.attempt_registration("Alex")). to eq("Thank you for registering, please login and have fun!") #should allow 'Alex' to register
    end

    it "should allow users to register if name does not exist" do #tests that application allows user to register if their account does not exist
        expect(@controller.attempt_registration("bob")). to eq("Thank you for registering, please login and have fun!") #should allow 'bob' to register
    end

    it "should allow users to login if name exists" do #tests that application allows user to use the login feature if their user exists
        expect(@controller.attempt_login("Bob")). to eq("Hello Bob!") #prints 'Hello Bob!' if Bob logs in
    end

    it "should allow users to login if name exists" do #tests that application allows user to use the login feature if their user exists
        expect(@controller.attempt_login("Steve")). to eq("Hello Steve!") #prints 'Hello Steve!' if Steve logs in
    end

    it "should stops users from logging in if name exists" do #tests that application prevents users from logging in if they haven't registered
        expect(@controller.attempt_login("bob")). to eq("You have not registered yet, please register first.") #should prevent 'bob' from logging in
    end

    it "should stops users from logging in if name exists" do #tests that application prevents users from logging in if they haven't registered
        expect(@controller.attempt_login("alex")). to eq("You have not registered yet, please register first.") #should prevent 'alex' from logging in
    end


end