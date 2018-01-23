class UsersController < ApplicationController
  # Инициализируем объект User для экшенов кроме :index, :create, :new
  before_action :load_user, except: [:index, :create, :new]

  # Проверяем имеет ли юзер доступ к экшену для всей дествий, кроме index, new, create, show
  before_action :authorize_user, except: [:index, :new, :create, :show]

  # Экшен index со списком всех юзеров
  def index
    @users = User.all
    @all_questions = Question.all
  end

  # Экшен new создает нового пользователя, но пока не добавляет в базу
  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  # Экшен create сохраняет и добавляет в базу нового пользователя
  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    # Достаем пользователя со всеми его параметрами (полями), которые были заданы
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      # Редиректим на страницу пользователя с сообщением
      redirect_to user_path(@user), notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  # Удаление пользователя
  def destroy
    @user.destroy

    # Редиректим на главную с сообщением
    redirect_to root_url, notice: 'Ваш аккаунт удален'
  end

  def edit; end

  # Обновление параметров пользователя
  def update
    if @user.update(user_params)

      # Редиректим на страницу пользователя с сообщением
      redirect_to user_path(@user), notice: 'Данные обновлены!'
    else

      # иначе рендерим пустой экшен edit
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build

    # Создаем три переменные с количеством вопросов, отвеченных вопросов и
    # неотвеченных вопросов
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count

    @text = nil
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :head_color, :name, :username, :avatar_url)
  end
end
