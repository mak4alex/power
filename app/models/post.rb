class Post < ActiveRecord::Base
  searchkick fields: ['title^2', 'body']
  
  has_many :visits
end
