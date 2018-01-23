class Question < ApplicationRecord
  # вопрос принадлежит пользователю
  belongs_to :user

  # у вопроса есть автор
  belongs_to :author, class_name: 'User', optional: true

  # у вопроса может быть много хэштегов
  has_and_belongs_to_many :hashtags

  # текст вопроса не должен быть пустым и быть длиннее 255 символов
  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }

  # перед сохранением модели, дергаем метод find_hashtags
  before_save :find_hashtags

  # метод нахождения хэштегов в тексте или ответе вопроса
  def find_hashtags
    # обнуляем массив с хэштегами перед нахождением новых, чтобы изавиться от старых
    self.hashtags = []

    # сканируем текст или ответ вопроса на наличие хэштегов, переводим найденные хэштеги в нижний регистр и
    # записываем все в массив hashtags_array
    hashtags_array = "#{text} #{answer}".scan(/#[а-яА-Яa-zA-z-]+[^0-9.<> ?!@#$%^&*()_]+/).map(&:downcase).uniq

    # создаем экземпляры модели Hashtag по имени и добавляем их в соединительнцю таблицу question.hashtags
    hashtags_array.each { |h| self.hashtags << Hashtag.find_or_create_by(name: h) }
  end
end
