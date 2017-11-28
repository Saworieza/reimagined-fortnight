class Comment < ApplicationRecord
  has_attached_file :media, :storage => :cloudinary, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :media, content_type: /\Aimage\/.*\z/

  # acts_as_votable
  include PublicActivity::Common
  
  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :content

  belongs_to :user
  belongs_to :tweet
end
