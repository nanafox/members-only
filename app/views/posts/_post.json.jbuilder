json.extract! post, :id, :title, :content, :slug, :status, :created_at, :updated_at
json.user_id post.user_id if current_user.present?
json.url post_url(post, format: :json)
