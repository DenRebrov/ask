class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :hashtags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  before_save :find_hashtags

  def find_hashtags
    self.hashtag = self.text.scan(/#\S+/)
  end
end
