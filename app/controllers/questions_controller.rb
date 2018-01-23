class QuestionsController < ApplicationController
  # Инициализируем объект вопрос для экшенов кроме :edit, :update, :destroy
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  # Проверяем имеет ли юзер доступ к экшену для всей дествий, кроме задавания
  # вопроса, это действие может вызвать даже неавторизованный пользователь.
  before_action :authorize_user, except: [:create]

  # Перед этим действием сработает before_action :load_questions и в переменной
  # @question у нас будет лежать вопрос с нужным id равным params[:id].
  def edit; end

  # Действие create будет отзываться при POST-запросе по адресу /questions из
  # формы нового вопроса, которая находится в шаблоне на странице
  # /questions/edit
  def create
    @question = Question.new(question_params)

    current_user.present? ? @question.author = current_user : @question.author = nil

    # проверка recaptcha на интернет-бота
    if verify_recaptcha(model: @question) && @question.save
      redirect_to user_path(@question.user), notice: "Вопрос задан."
    else
      render :edit
    end
  end

  # Перед этим действием сработает before_action :load_questions и в переменной
  # @question у нас будет лежать вопрос с нужным id равным params[:id].
  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен.'
    else
      render :edit
    end
  end

  # Удаляем вопрос
  def destroy
    user = @question.user
    @question.destroy

    # Редиректим пользователя на страницу пользователя
    redirect_to user_path(user), notice: 'Вопрос удален.'
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def authorize_user
    reject_user unless @question.user == current_user
  end

  def question_params
    if current_user.present? && params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer, :hashtag)
    else
      params.require(:question).permit(:user_id, :text, :hashtag)
    end
  end
end
