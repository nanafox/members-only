require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    sign_in @user
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count", 1) do
      post posts_url,
           params: {
             post: {
               title: "Test Post", content: "This is a test post",
               status: "public", slug: "test-slug"
             }
           }
    end

    assert_redirected_to post_path(Post.last)

    post = Post.last
    assert_equal "Test Post", post.title
    assert_equal "This is a test post", post.content.to_plain_text
    assert_equal "public", post.status
    assert_equal @user, post.user
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post),
          params: {
            post: {
              content: "Updated post content", slug: @post.slug,
              status: @post.status, title: @post.title
            }
          }

    Rails.logger.debug @post.errors.full_messages
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
