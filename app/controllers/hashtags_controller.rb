class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])
    @all_questions = Question.all
  end
end
