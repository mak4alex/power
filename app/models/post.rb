class Post < ActiveRecord::Base
  extend FriendlyId
  
  ORDER_OPTIONS = [['Visits', :visits], ['Created At', :created_at]]
  MAX_WEIGHT = 5
  
  searchkick fields: ['title^2', 'body']
  
  friendly_id :slug_candidates, use: [:slugged, :finders]
  def slug_candidates
    [ 
      :title,
      [:title, :id]
    ]
  end
  
  acts_as_votable
  
  has_many :visits
  has_many :comments
  
  paginates_per 10
  
  validates :title, presence: true, uniqueness: true, length: { in: 6..64 }
  validates :body, presence: true
  
  def weighted_average
    cached_votes_total == 0 ? 0 : cached_weighted_total / cached_votes_total
  end
  
end
