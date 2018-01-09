class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_and_belongs_to_many :hashtags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  before_save :find_hashtags

  def find_hashtags
    scanning_hashtags = "#{text} #{answer}".scan(/#\S+/).map(&:downcase)

    scanning_hashtags.each do |h|
      self.hashtags << Hashtag.find_or_create_by(name: h)
    end
  end
end