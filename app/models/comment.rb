class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, required: true
  
  validates :author, presence: true
  validates :body, presence: true
  
  acts_as_tree
end
