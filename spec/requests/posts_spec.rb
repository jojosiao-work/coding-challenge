require 'rails_helper'

RSpec.describe "/posts", type: :request do
  let!(:user) do
    user = User.create! email: "testuser@gmail.com", password: "testpassword"
    post "/users/login", :params => { email: user.email , password: user.password } 
  end

  let(:a_new_post) do
    a_new_post = { user_id: session[:user_id], post: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,", status: "public_status" }
  end

  let(:invalid_post) do
    invalid_post = { user_id: session[:user_id], post: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,", status: "private_status" }
  end

  let!(:new_post) do 
    # given that the user is successfully logged in, session must be populated by the users controller.
    new_post = Post.create! user_id: session[:user_id], post: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,", status: "public_status" 
  end
  
  describe "GET /index" do
    it "renders a successful response" do
      get posts_url 
      # this is to test if the page includes the shared partial template with the logout href link 
      expect(response.body.include?("Logout")).to eq(true)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get posts_url , :params => {:id => new_post.id}
      # this is to test if the page includes the shared partial template with the logout href link 
      expect(response.body.include?("Far far away")).to eq(true)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_post_url
      # this is to test if the page includes the headline New Post in the page. 
      expect(response.body.include?("New Post")).to eq(true)
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_post_url(new_post)
      expect(response.body.include?("Far far away")).to eq(true)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Post" do
        expect {
          post posts_url, params: { post: a_new_post }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post posts_url, params: { post: a_new_post }
        expect(response).to redirect_to(post_url(Post.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post posts_url, params: { post: invalid_post }
        }.to change(Post, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post posts_url, params: { post: invalid_post }
        # if create with POST method fails, we will not go away to this page because of the error.
        expect(response).to render_template("new")

      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:a_new_post2) {
        a_new_post2 = { user_id: session[:user_id], post: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,", status: "private_status" }
      }




      it "updates the requested post" do
        post = Post.create! a_new_post
        patch post_url(post), params: { post: a_new_post2 }
        post.reload
        expect(response).to redirect_to(post_path)
      end

      it "redirects to the post" do
        post = Post.create! a_new_post
        patch post_url(post), params: { post: a_new_post2 }
        post.reload
        expect(response).to redirect_to(post_url(post))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        post = Post.create! a_new_post
        patch post_url(post), params: { post: invalid_post }
        # if editing with POST method fails, we will not go away to this page because of the error.
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE /destroy" do
    let(:a_new_post3) {
        a_new_post3 = { user_id: session[:user_id], post: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,", status: "private_status" }
      }

    it "destroys the requested post" do
      post = Post.create! a_new_post3
      expect {
        delete post_url(post)
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! a_new_post3
      delete post_url(post)
      expect(response).to redirect_to(posts_url)
    end
  end
end
