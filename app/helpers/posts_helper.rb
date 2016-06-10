module PostsHelper
  def cache_key_for_posts
    count          = Post.count
    max_updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/all-#{count}-#{max_updated_at}"
  end
  
  def most_visited_posts(count = 5)
    Post.order(visits_count: :desc).limit(count)
  end
  
  def most_rated_posts(count = 5)
    Post.order(cached_weighted_total: :desc).limit(count)
  end
  
  def comments_tree_for(comments)
    comments.map do |comment, nested_comments|
      render(comment) +
          (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: "replies") : nil)
    end.join.html_safe
  end
end
