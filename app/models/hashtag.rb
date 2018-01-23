class Hashtag < ApplicationRecord
  # у хэштега может быть много вопросов
  has_and_belongs_to_many :questions

  # имя хэштега должно быть уникально
  validates :name, uniqueness: true
end
