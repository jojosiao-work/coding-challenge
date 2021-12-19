require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user1 = User.new(email: "testuser1@gmail.com" , password: "testpassword") 
    @user2 = User.new(email: "testuser1@gmail.com" , password: "testpassword2") 
    @user3 = User.new(email: "" , password: "testpassword") 
    @user4 = User.new(email: "testuser1gmail.com" , password: "") 
  end

  describe "New User" do
    it "empty password" do
      @user4.validate
      expect(@user4.errors[:password][0]).to eq("can't be blank") 
    end

    it "email already exists" do
      @user1.save
      @user2.validate
      expect(@user2.errors[:email][0]).to eq("has already been taken")
    end

    it "saves successful record" do
      @user = User.new email:"testuser5@gmail.com", password: "testpassword"
      expect(@user.save).to eq(true)
    end
  end



end
