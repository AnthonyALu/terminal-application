require_relative "../user.rb"


describe GameController do
    before(:each) do
        @controller = GameController.new()
        @controller.currentUser = "Bob"
        @controller.userHashes = {"Bob" => 10, "Steve" => 5}
    end

    it "should show stats" do
        expect(@controller.show_stats).to eq(10)
    end

    it "should show stats for other users in hash" do
        @controller.currentUser = "Steve"
        expect(@controller.show_stats).to eq(5) 
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

end