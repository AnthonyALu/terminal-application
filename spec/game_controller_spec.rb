require_relative "../user.rb"
require_relative "../game_controller.rb"

describe GameController do
    before(:each) do
        @controller = GameController.new()
        @controller.currentUid = 0
        @controller.userHashes = {"Bob" => 0, "Steve" => 1}
        @controller.userData << {:name => "Bob", :high_score => 0, :accuracy => 0, :worst_character => "None!"}
        @controller.userData << {:name => "Steve", :high_score => 0, :accuracy => 0, :worst_character => "None!"}
        @controller.currentUserData = @controller.userData[0]
    end

    it "should show stats" do
        expect(@controller.show_stats).to eq("Name: Bob, WPM: 0, Accuracy: 0, Least accurate letter: None!")
    end

    it "should show stats for other users in hash" do
        @controller.currentUid = 1
        expect(@controller.show_stats).to eq("Name: Steve, WPM: 0, Accuracy: 0, Least accurate letter: None!")
    end

    it "should stop users from registering if name already exists" do
        expect(@controller.attempt_registration("Bob")). to eq("You already have an account, please login")
    end

    it "should stop users from registering if name already exists" do
        expect(@controller.attempt_registration("Steve")). to eq("You already have an account, please login")
    end

    it "should allow users to register if name does not exist" do
        expect(@controller.attempt_registration("Alex")). to eq("Thank you for registering, please login and have fun!")
    end

    it "should allow users to register if name does not exist" do
        expect(@controller.attempt_registration("bob")). to eq("Thank you for registering, please login and have fun!")
    end

    it "should allow users to login if name exists" do
        expect(@controller.attempt_login("Bob")). to eq("Hello Bob!")
    end

    it "should allow users to login if name exists" do
        expect(@controller.attempt_login("Steve")). to eq("Hello Steve!")
    end

    it "should stops users from logging in if name exists" do
        expect(@controller.attempt_login("bob")). to eq("You have not registered yet, please register first.")
    end

    it "should stops users from logging in if name exists" do
        expect(@controller.attempt_login("alex")). to eq("You have not registered yet, please register first.")
    end

    it "should display stats" do
        expect(@controller.show_stats).to eq("Name: Bob, WPM: 0, Accuracy: 0, Least accurate letter: None!")
    end

end