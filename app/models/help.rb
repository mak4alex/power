class Help < ActiveRecord::Base
  has_attached_file :attachment
  

  validates_attachment :attachment, 
    size: { in: 0..1.megabytes }, 
    content_type: { 
      content_type: [ "image/jpg", "image/jpeg", "image/png", "image/gif", 'text/plain'] 
    }
  
  validates :email, presence: true, format: { with: Devise::email_regexp }
  validates :name, presence: true, length: { in: 3..64 }
  validates :topic, presence: true, length: { in: 3..64 }
  validates :body, presence: true, length: { maximum: 1024 }
  
end