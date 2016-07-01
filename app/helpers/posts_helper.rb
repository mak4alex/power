module PostsHelper
  def cache_key_for_posts
    count          = Post.count
    max_updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/all-#{count}-#{max_updated_at}"
  end
  
  def most_visited_posts(count = 7)
    query = %{
    	posts.id, posts.title, 
    	posts.body, posts.slug, visits_count
    }
    Post.select(query).order('visits_count DESC').limit(count)
  end
  
  def most_rated_posts(count = 7)
    query = %{
    	posts.id, posts.title, 
    	posts.body, posts.slug, 
    	(cached_weighted_total / cached_votes_total) AS rating
    }
    Post.select(query).order('rating DESC').limit(count)
  end
  
  def has_in_favourite?(post)
    params[:q].present? ? current_user.has_in_favourite?(post) : post.has_favourite
  end
  
  def comments_tree_for(comments)
    comments.map do |comment, nested_comments|
      render(comment) +
          (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: "replies") : nil)
    end.join.html_safe
  end
end
