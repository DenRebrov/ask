class CreateHashtagsQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtags_questions do |t|
      t.references :hashtag
      t.references :question
    end
  end
end
