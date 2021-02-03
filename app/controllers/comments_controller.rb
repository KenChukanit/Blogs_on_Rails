class CommentsController < ApplicationController
    before_action :find_comment,   only: [:destroy]
    before_action :authenticate_user!
    before_action :authorize_user_comment!, only: [:destroy]

    def create
        @post = Post.find params[:post_id]
        @comment=Comment.new comment_params
        @comment.post = @post
        @comment.user = current_user
        
        if @comment.save
            redirect_to post_path(@post), notice: 'Comment created!'
        else
            render '/posts/show'
        end
    end
    
    def destroy
        if @comment.destroy
        redirect_to post_path(@post), alert: "Comment deleted"
        else  
            render '/posts/show'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

    def find_comment
        @post = Post.find params[:post_id]
        @comment = Comment.find params[:id]
    end

    def authorize_user_comment!
        @comment = Comment.find params[:id]
        redirect_to posts_path, alert: 'Only the owner is authorized.' unless can?(:crud, @comment)
    end
    
end
