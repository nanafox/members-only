require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    sign_in @user
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "should create post" do
    visit posts_url
    click_on "New post"

    find("trix-editor").set("New Post Title")
    fill_in "Slug", with: @post.slug
    select @post.status, from: "Status"
    fill_in "Title", with: @post.title
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "should update Post" do
    visit post_url(@post)
    click_on "Edit", match: :first

    find("trix-editor").set("Updated content")
    fill_in "Slug", with: @post.slug
    select "private", from: "Status"
    fill_in "Title", with: @post.title
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "should destroy Post" do
    visit post_url(@post)
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
