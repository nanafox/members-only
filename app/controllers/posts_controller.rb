class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :validate_user!, only: %i[ destroy edit update ]
  before_action :set_current_user_posts, only: %i[me]

  # GET /posts or /posts.json
  def index
    # TODO: Add authorization to view posts based on the visibility status
    # set by the owner of the post. So post authors will be the only ones to
    # see posts they've marked as 'draft' or 'private'. And authenticated
    # users can see 'public' and 'archived' posts.

    # unauthenticated users should see only public posts
    if user_signed_in?
      @posts = Post.recent.includes(:user).limit(30)
    else
      @posts = Post.recent.where(status: "public").limit(30)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  def me
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    if action_name == :show
      @post = Post.includes(
        :user, :rich_text_content, comments: [ :user ],
      ).find_by(slug: params.expect(:slug))
    else
      @post = Post.find_by(slug: params.expect(:slug))
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.expect(post: [ :title, :content, :slug, :status ])
  end

  def validate_user!
    if current_user != @post.user
      redirect_to post_path(@post),
        status: :see_other,
        alert: "You are not authorized to perform this action!"
    end
  end

  def set_current_user_posts
    @posts = current_user.posts
  end
end
