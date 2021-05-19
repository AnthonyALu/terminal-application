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

end