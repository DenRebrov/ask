class HashtagsController < ApplicationController
  def show
    # Достаем хэштег по id
    @hashtag = Hashtag.find(params[:id])

    @all_questions = Question.all

    @users = User.all
  end
end
