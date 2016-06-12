class Post < ActiveRecord::Base
  extend FriendlyId
  

  ORDER_OPTIONS = [ 
    ['Order By:', '', selected: true, disabled: true], 
    ['Visits', :visits_count], 
    ['Rating', :cached_weighted_total],
    ['Updated At', :updated_at],
    ['Created At', :created_at]
  ]
  MAX_WEIGHT = 5
  DEFAULT_PER_PAGE = 10
  
  
  searchkick fields: [ 'title^2', 'body' ]
  
  acts_as_votable
  
  
  friendly_id :slug_candidates, use: [:slugged, :finders]
  def slug_candidates
    [ 
      :title,
      [:title, :id]
    ]
  end
  
 
  has_many :visits
  has_many :comments
 
  
  validates :title, presence: true, uniqueness: true, length: { in: 6..64 }
  validates :body, presence: true
  
  
  scope :with_favourite_of, -> (params) do
    query = %{
      posts.id, posts.*, 
      (SELECT 1 FROM `favourites` 
      WHERE `favourites`.`user_id` = #{params[:user_id]} 
        AND `favourites`.`post_id` = posts.id LIMIT 1) AS has_favourite 
    }
    select(query) if params[:user_id].present? 
  end
  

  def has_in_favourite?(post)
    Favourite.exists?(user: self, post: post)
  end
  
  scope :owned, -> (params) { order(params[:sort_field] => params[:sort_order]) unless params[:my].blank? }
  scope :sort, -> (params) { order(params[:sort_field] => params[:sort_order]) unless params[:sort_field].blank? }
  
  
  def self.fetch(params)
    with_favourite_of(params)
      .page(params[:page])
      .per(params[:per_page] || DEFAULT_PER_PAGE)
      .sort(params)
  end
  
  def self.fetch_with_search(params)
    search( params[:q], fields: [:title, :body],
      highlight: { tag: '<mark>', fields: [ :title, :body ] },
      order: { params[:sort_field] => params[:sort_order] },
      page: params[:page] || 1, per: params[:per_page] || DEFAULT_PER_PAGE )
  end
  
  def weighted_average
    cached_votes_total == 0 ? 0 : cached_weighted_total / cached_votes_total
  end
  
end
