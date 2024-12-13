class RepliesController < ApplicationController
  before_action :set_comment
  before_action :set_post

  def create
    @reply = @comment.replies.build(reply_params)

    if @reply.save
      redirect_to @post
    else
      flash.now[:alert] = "Failed to add comment"
      redirect_to @post, status: :see_other
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params.expect(:comment_id))
  end

  def set_post
    @post = Post.find_by(slug: params.expect(:post_slug))
  end

  def reply_params
    params.expect(reply: [ :content ]).merge({ user: current_user, post: @post })
  end
end
