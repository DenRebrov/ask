# В этом файле мы можем писать вспомогательные методы (хелперы) для шаблонов,
# (представлений, вьюх) нашего приложения

module ApplicationHelper
  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть
  # или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  # метод склонения, который позволяет склонять слова в зависимости от их множественного или единственного числа
  def decline(number_question, vopros, voprosa, voprosov)
    remainder = number_question % 10
    remainder100 = number_question % 100

    @text = vopros if remainder == 1
    @text = voprosa if remainder >= 2 && remainder <= 4
    @text = voprosov if remainder > 4 || remainder == 0
    @text = voprosov if remainder100 >= 11 && remainder100 <= 14

    return @text
  end

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
