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
  
  acts_as_taggable 
  
  friendly_id :slug_candidates, use: [:slugged, :finders]
  def slug_candidates
    [ 
      :title,
      [:title, :id]
    ]
  end
  
 
  has_many :visits
  has_many :comments
  
  belongs_to :author, class_name: 'User', foreign_key: 'user_id', required: true
 
  
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
  

  
  scope :owned, -> (params) { where(user_id: params[:user_id]) if params[:my].present? && params[:user_id].present? }
  scope :sort, -> (params) { order(params[:sort_field] => params[:sort_order]) if params[:sort_field].present? }
  scope :in_favour, -> (params) do
    if params[:fav].present? 
      query = %{
        EXISTS (
          SELECT 1 
          FROM `favourites` 
          WHERE `favourites`.`user_id` = #{params[:user_id]} 
            AND `favourites`.`post_id` = posts.id LIMIT 1
        )
      }
      where(query)
    end
  end
  
  def self.fetch(params)
    with_favourite_of(params)
      .owned(params)
      .in_favour(params)
      .page(params[:page])
      .per(params[:per_page] || DEFAULT_PER_PAGE)
      .includes(:author)
      .sort(params)
  end
  
  def self.fetch_with_search(params)
    options = {
      fields: [:title, :body],
      operator: 'or',
      highlight: { fields: [:title, :body], tag: '<u>' },
      page: params[:page] || 1,
      per_page: params[:per_page] || DEFAULT_PER_PAGE
    }
    
    if params[:sort_field].present?
      options[:order] = { params[:sort_field] => params[:sort_order] || 'desc' } 
    end
    
    if params[:user_id].present?
      options[:where] = { user_id: params[:user_id] } if params[:my].present?
      
      if params[:fav].present?
        options[:where] ||= {}
        options[:where][:id] =  Post.where("EXISTS (SELECT 1 FROM `favourites` WHERE `favourites`.`user_id` = #{params[:user_id]} AND `favourites`.`post_id` = posts.id LIMIT 1)").ids
      end
    end
    
    search(params[:q], options)
  end
  
  def weighted_average
    cached_votes_total == 0 ? 0 : cached_weighted_total / cached_votes_total
  end
  
end
