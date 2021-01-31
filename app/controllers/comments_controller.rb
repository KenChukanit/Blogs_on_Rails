class CommentsController < ApplicationController
    before_action   :find_comment,   only: [:destroy]
    before_action :authenticate_user!

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

end
