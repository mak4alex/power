class Post < ActiveRecord::Base
  extend FriendlyId
  
  ORDER_OPTIONS = [['Visits', :visits], ['Created At', :created_at]]
  
  searchkick fields: ['title^2', 'body']
  
  friendly_id :slug_candidates, use: [:slugged, :finders]
  def slug_candidates
    [ 
      :title,
      [:title, :id]
    ]
  end
  
  has_many :visits
  has_many :comments
  
  paginates_per 10
  
  validates :title, presence: true, uniqueness: true, length: { in: 6..64 }
  validates :body, presence: true
  
end
