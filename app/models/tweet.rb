class Tweet < ApplicationRecord
  has_attached_file :media, :storage => :cloudinary, styles: { medium: "640x", thumb: "100x100>" }, default_url: "last-phot12-large.jpg"
  validates_attachment_content_type :media, content_type: /\Aimage\/.*\z/

  after_create :add_mentions
  acts_as_votable

  include SimpleHashtag::Hashtaggable
  hashtaggable_attribute :body

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  
  has_many :comments, dependent: :destroy
  
  belongs_to :user, dependent: :destroy
  belongs_to :tweet, optional: true
  
  def tweet_type
    if tweet_id? && body?
      "quote-tweet"
    elsif tweet_id?
      "retweet"
    else
      "tweet"
    end
  end
  
  def add_mentions
    Mention.create_from_text(self)
  end

end
