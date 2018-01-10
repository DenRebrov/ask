class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])
    @all_questions = Question.all
    @users = User.all
  end
end
