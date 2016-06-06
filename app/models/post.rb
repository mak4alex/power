class Post < ActiveRecord::Base
  ORDER_OPTIONS = [['Visits', :visits], ['Created At', :created_at]]
  
  has_many :visits
  has_many :comments
  
  paginates_per 10
  
end
