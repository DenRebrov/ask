class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_and_belongs_to_many :hashtags

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  before_save :find_hashtags

  def find_hashtags
    question_hashtag_name = self.text.scan(/#\S+/).map(&:downcase).uniq
    self.answer.present? ? answer_hashtag_name = self.answer.scan(/#\S+/).map(&:downcase).uniq : answer_hashtag_name = nil

    @hashtag = Hashtag.new(name: question_hashtag_name, answer: answer_hashtag_name)
    self.hashtags << @hashtag

    #self.hashtags.each do |hash|
    #  hash.name.delete('[]",')
    #  hash.answer.delete('[]",') if hash.answer.present?
    #end
  end
end