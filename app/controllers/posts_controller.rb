class PostsController < ApplicationController

    before_action   :find_post, only: [:show, :edit, :update, :destroy]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new post_params
    end

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def show
    end

    def edit
    end

    def update
        if @post.update post_params
            redirect_to post_path(@post.id)
        else 
            render :edit
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private

    def post_params
        parms.require(:post).permit(:title, :body)
    end

    def find_post
        @post = Post.find params[:id]
    end


end
