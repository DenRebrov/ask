class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_and_belongs_to_many :hashtags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  before_save :find_hashtags

  def find_hashtags
    self.hashtags = []
    hashtags_array = "#{text} #{answer}".scan(/#[а-яА-Яa-zA-z-]+[^0-9.<> ?!@#$%^&*()_]+/).map(&:downcase).uniq
    hashtags_array.each { |h| self.hashtags << Hashtag.find_or_create_by(name: h) }
  end
end
