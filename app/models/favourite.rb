class Favourite < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :post, required: true
  
  validates :user, uniqueness: { scope: :post }

end
