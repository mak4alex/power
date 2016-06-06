class Post < ActiveRecord::Base
  ORDER_OPTIONS = [['Visits', :visits], ['Created At', :created_at]]
  searchkick fields: ['title^2', 'body']
  
  has_many :visits
  has_many :comments
  
  paginates_per 10
  
  validates :title, presence: true, uniqueness: true, length: { in: 6..64 }
  validates :body, presence: true
  
end
