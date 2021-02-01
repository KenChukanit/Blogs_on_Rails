class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action  :find_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!,only:[:edit,:update,:destroy]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        @post.user = current_user
        if @post.save
            flash[:notice] = "Post created."
            redirect_to post_path(@post.id)
        else
            render :new
        end
    end

    def index
        @posts = Post.all.order(created_at: :desc)
    end

    def show
        @comments = @post.comments.order(created_at: :desc)
        @comment = Comment.new
    end

    def edit
    end

    def update
        if @post.update post_params
            flash[:notice] = "Post updated."
            redirect_to post_path(@post.id)
        else 
            render :edit
        end
    end

    def destroy
        if @post.destroy
            flash[:alert] = "Post deleted."
        redirect_to posts_path
        else  
            render :show
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def find_post
        @post = Post.find params[:id]
    end

    def authorize_user!
        redirect_to root_path, alert: 'Only the owner is authorized.' unless can?(:crud, @post)
    end

end
