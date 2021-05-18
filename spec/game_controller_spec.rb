require_relative "../user.rb"

describe GameController do
    before(:each) do
        @controller = GameController.new()
        @controller.currentUser = "Bob"
        @controller.userHashes = {"Bob" => 10, "Steve" => 5}
    end

    it "should show stats" do
        expect(@controller.show_stats).to eq(10)
        @controller.currentUser = "Steve"
        expect(@controller.show_stats).to eq(5) 
    end

    it "should show stats for other users in hash" do
        @controller.currentUser = "Steve"
        expect(@controller.show_stats).to eq(5) 
    end

end