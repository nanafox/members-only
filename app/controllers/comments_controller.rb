class CommentsController < ApplicationController
  before_action :set_post, only: %i[ create edit update destroy ]
  before_action :set_comment, only: %i[ edit update destroy ]
  before_action :authenticate_user!

  def new
    @comment = @post.comments.build
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.create(comment_params)

    if @comment.persisted?
      redirect_to post_path(@post), notice: "Comment was successfully created."
    else
      redirect_to post_path(@post),
        status: :see_other,
        alert: "Failed to add comment: #{@comment.errors.first.full_message}"
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment was successfully updated."
    else
      flash.now[:alert] = "Failed to update comment"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html {
        flash.now[:notice] = "Comment was successfully destroyed."
        redirect_to post_path(@post),
          status: :see_other
      }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @post.comments.find(params.expect(:id))
  end

  def set_post
    @post = Post.find(params.expect(:post_id))
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.expect(comment: [ :content ]).merge({ user: current_user })
  end
end
