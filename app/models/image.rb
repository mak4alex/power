class Image < ActiveRecord::Base
  has_attached_file :file, styles: {
    thumb: "100x100#",
    medium: "800x600>" 
  }

  validates_attachment :file, 
    presence: true,
    size: { in: 0..1.megabytes }, 
    content_type: { content_type: [ "image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def url_thumb
    file.url(:thumb)
  end

  def url_medium
    file.url(:medium)
  end

end
