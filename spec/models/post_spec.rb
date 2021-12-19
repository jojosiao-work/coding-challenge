require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = User.create email: "testuser1@gmail.com", password: "testpassword"
  end

  describe "New Post" do
    it "saves new post by user" do
      @post = Post.new
      @post.user = @user
      @post.post = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
      Suspendisse interdum convallis arcu a laoreet. Morbi mattis 
      ultricies volutpat. Fusce auctor vel arcu a lacinia. Curabitur 
      justo nibh,"
      expect(@post.save).to eq(true)
    end

    it "checks for minimum length of the post to at least 50" do
      @post  = Post.new
      @post.user = @user
      @post.post = "Lorem ipsum dolor Suspendisse interdum"
      @post.validate
      expect(@post.errors[:post][0]).to eq("is too short (minimum is 50 characters)")
    end

    it "limits the length of the post to 255" do
      @post = Post.new
      @post.user = @user
      @post.post = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
      Suspendisse interdum convallis arcu a laoreet. Morbi mattis 
      ultricies volutpat. Fusce auctor vel arcu a lacinia. Curabitur 
      justo nibh, ultricies eu pharetra vitae, dapibus sed nisi. 
      Proin semper lorem vitae urna tempor iaculis. Nunc varius massa 
      non nisi mollis, sit amet aliquet tortor ullamcorper. Nullam 
      mollis nunc et dui sagittis bibendum id a lorem. In hac habitasse 
      platea dictumst.
      Vestibulum maximus massa id sem mollis, id mattis leo dapibus. 
      Proin sollicitudin diam ac turpis semper, at congue est tincidunt. 
      Pellentesque nec neque interdum, pellentesque lacus vitae, posuere 
      diam. Aenean tortor quam, laoreet id dui eu, rhoncus placerat ex. 
      Suspendisse finibus venenatis convallis. Integer blandit tortor metus, 
      vel vestibulum felis ullamcorper pretium. In quis turpis vitae turpis 
      feugiat aliquet. Pellentesque porttitor molestie ligula et semper. 
      Mauris imperdiet purus at consequat ultrices. Donec malesuada aliquam 
      tempor. Nam tristique lacus non velit semper, id semper ipsum accumsan.
      Suspendisse id risus feugiat, dignissim est sed, lobortis sem. Quisque 
      ac lacinia erat, sed tristique nibh. Maecenas vitae pulvinar velit, vel 
      pretium urna. Nam id nisi auctor, pellentesque eros quis, accumsan purus. 
      Ut a neque nibh. Phasellus semper nisl vel arcu lacinia fringilla. In 
      feugiat dui tellus, ac molestie elit faucibus at.
      Sed velit massa, ultrices ut felis eu, euismod lobortis est. Maecenas 
      in mi cursus, suscipit libero sed, convallis odio. Cras facilisis est 
      dapibus dui euismod, nec semper metus placerat. Proin ut eros est. Fusce 
      in accumsan ligula. Praesent nec blandit leo. Curabitur aliquet turpis 
      vitae eros euismod vulputate. Ut varius ligula nec massa."
      @post.validate
      expect(@post.errors[:post][0]).to eq("is too long (maximum is 255 characters)")
    end
  end



end
