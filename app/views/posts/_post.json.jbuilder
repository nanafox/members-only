json.extract! post, :id, :user_id, :title, :body, :slug, :status, :created_at, :updated_at
json.url post_url(post, format: :json)
