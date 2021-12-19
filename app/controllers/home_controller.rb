class HomeController < ApplicationController

    def index
        @posts = Post.where(status:"public_status")
    end

end
