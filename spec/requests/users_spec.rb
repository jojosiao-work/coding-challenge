require 'rails_helper'

RSpec.describe "users", type: :request do
  
  describe "GET users/register" do
    it "renders registration form" do
      get "/users/register"
      expect(response).to render_template("register")
    end
  end

  describe "POST users/register" do
    it "accepts new user registration" do
      post "/users/register", :params => { :user => { email: "testuser10001@gmail.com", password: "testpassword" }}
      expect(response).to redirect_to(users_login_path)     
    end
  end

  describe "GET /login" do
    it "renders login form" do
      get "/users/login"
      expect(response).to render_template("login")
    end 
  end

  describe "POST /login" do
    it "logs in the registered user" do
      user = User.create! email: "testuser@gmail.com", password: "testpassword"
      post "/users/login", :params => { email: "testuser@gmail.com",password: "testpassword" } 
      expect(response).to redirect_to(posts_path)
    end

  end

end
