class Post < ActiveRecord::Base
  has_many :visits
  has_many :comments
end
